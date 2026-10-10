/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\execution.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\cp_mp\execution;
#using scripts\engine\utility;
#namespace execution;

function init_cp_execution() {
  create_execution_devgui();
  level thread function_d3a46ebba0eb3257(@ "hash_3764674c95711828", &execution_debug);
}

function execution_debug(itemref) {
  items = strtok(itemref, "_");
  playertoks = strtok(itemref, "-");
  params = strtok(itemref, "&");
  player = undefined;

  if(playertoks.size > 1) {
    playerint = int(playertoks[0]);
    player = level.players[playerint];
  }

  level.players[0] scripts\cp_mp\execution::_giveexecution(itemref);
}

function create_execution_devgui() {
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Neck Stab\" \"set scr_giveexecution neck_stab\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Throat Cut\" \"set scr_giveexecution throat_cut\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / execution_default_west\" \"set scr_giveexecution execution_default_west\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / execution_default_east\" \"set scr_giveexecution execution_default_east\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Charly / Execution 000 Baton\" \"set scr_giveexecution execution_mp_western_charly_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Charly / Execution 001 Pistol\" \"set scr_giveexecution execution_mp_western_charly_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Murphy / Execution 003 Baton\" \"set scr_giveexecution execution_mp_western_murphy_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Murphy / Execution 004 Pistol\" \"set scr_giveexecution execution_mp_western_murphy_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Otter / Execution 006 Baton\" \"set scr_giveexecution execution_mp_western_otter_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Otter / Execution 007 Pistol\" \"set scr_giveexecution execution_mp_western_otter_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Wyatt / Execution 009 Knife\" \"set scr_giveexecution execution_mp_western_wyatt_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Wyatt / Execution 010 Cattle Prod\" \"set scr_giveexecution execution_mp_western_wyatt_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Golem / Execution 012 Knife\" \"set scr_giveexecution execution_mp_western_golem_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Golem / Execution 013 Cattle Prod\" \"set scr_giveexecution execution_mp_western_golem_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Domino / Execution 015 Knife\" \"set scr_giveexecution execution_mp_western_domino_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Domino / Execution 016 Cattle Prod\" \"set scr_giveexecution execution_mp_western_domino_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / D - Day / Execution 018 Hatchet\" \"set scr_giveexecution execution_mp_western_dday_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / D - Day / Execution 019 Martial Arts\" \"set scr_giveexecution execution_mp_western_dday_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Alice / Execution 021 Hatchet\" \"set scr_giveexecution execution_mp_western_alice_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Alice / Execution 022 Martial Arts\" \"set scr_giveexecution execution_mp_western_alice_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Raines / Execution 024 Hatchet\" \"set scr_giveexecution execution_mp_western_raines_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Raines / Execution 025 Martial Arts\" \"set scr_giveexecution execution_mp_western_raines_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Bale / Execution 032 Sambo\" \"set scr_giveexecution execution_mp_eastern_bale_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Bale / Execution 033 Halligan\" \"set scr_giveexecution execution_mp_eastern_bale_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Minotaur / Execution 035 Sambo\" \"set scr_giveexecution execution_mp_eastern_minotavr_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Minotaur / Execution 036 Halligan\" \"set scr_giveexecution execution_mp_eastern_minotavr_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Rodion / Execution 038 Sambo\" \"set scr_giveexecution execution_mp_eastern_rodion_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Rodion / Execution 039 Halligan\" \"set scr_giveexecution execution_mp_eastern_rodion_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Syd / Execution 041 Karambit\" \"set scr_giveexecution execution_mp_eastern_syd_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Syd / Execution 042 Brass Knuckles\" \"set scr_giveexecution execution_mp_eastern_syd_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Yegor / Execution 044 Karambit\" \"set scr_giveexecution execution_mp_eastern_yegor_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Yegor / Execution 045 Brass Knuckles\" \"set scr_giveexecution execution_mp_eastern_yegor_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Kreuger / Execution 047 Karambit\" \"set scr_giveexecution execution_mp_eastern_kreuger_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Kreuger / Execution 048 Brass Knuckles\" \"set scr_giveexecution execution_mp_eastern_kreuger_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Grinch / Execution 050 Machete\" \"set scr_giveexecution execution_mp_eastern_grinch_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Grinch / Execution 051 Rungu\" \"set scr_giveexecution execution_mp_eastern_grinch_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Zane / Execution 053 Machete\" \"set scr_giveexecution execution_mp_eastern_zane_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Zane / Execution 054 Rungu\" \"set scr_giveexecution execution_mp_eastern_zane_variant_1\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Azur / Execution 056 Machete\" \"set scr_giveexecution execution_mp_eastern_azur_default\" \n";
  addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug:2 / Executions / Give / Azur / Execution 057 Rungu\" \"set scr_giveexecution execution_mp_eastern_azur_variant_1\" \n";
  addentrytodevgui(cmd);
}

function function_94c333bd965e6685() {
  while(!isDefined(self.operatorcustomization)) {
    waitframe();
  }

  self.operatorcustomization.execution = "execution_000";
  scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
}

function execution_swapexecutionsafterkill() {
  self endon("disconnect");
  self notify("execution_swapExecutionsAfterKill");
  self endon("execution_swapExecutionsAfterKill");

  while(true) {
    old_value = self.operatorcustomization.execution;
    self waittill("killed_ai_via_execution");

    if(cointoss()) {
      old_value = "execution_00" + randomintrange(0, 9);
    } else {
      old_value = "execution_0" + randomintrange(10, 16);
    }

    self.operatorcustomization.execution = old_value;
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
  }
}