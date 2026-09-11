/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_downtown_cs.gsc
***************************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_donetsk_safehouse_downtown_cs")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_donetsk_safehouse_downtown_cs");
  var_2 = spawnStruct();
  thread cs_return_and_wait_for_flag(level, var_0, var_1, var_2);

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime()) {
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
    return;
  }
}

function cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1)) {
    var_1 = "stk";
  }

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "cp_donetsk_safehouse_downtown_cs");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);
  thread createmodels(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_donetsk_safehouse_downtown_cs");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_donetsk_safehouse_downtown_cs");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19418, -21800.8, 34.5), (0, 0, 0), "auto1", "auto2", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19251, -22137, 22.25), (0, 315, 0), "dwn_twn_safehouse_gate", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19432, -21791.5, 21.5), (0, 135, 0), "auto4", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19074.5, -21925.5, 36.75), (0, 315, 0), "dwn_twn_safehouse_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19431, -21792, 20.5), (0, 330, 0), "auto2", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19418, -21800.8, 34.5), (0, 0, 0), "auto3", "auto4", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25947.5, -12112, -207.5), (0, 135, 0), "auto6", "auto5", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25931.3, -12112.7, -221.25), (0, 270, 0), "auto7", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25910.9, -11979.1, -209.75), (0, 225, 0), "gunshop_safehouse_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25932.3, -12112.9, -222), (0, 105, 0), "auto5", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25947.5, -12112, -207.5), (0, 135, 0), "auto8", "auto7", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25398.5, -12041.1, -254), (0, 360, 0), "safehouse_gunshop_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25398.5, -12078.3, -254), (0, 360, 0), "safehouse_gunshop_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25398.5, -12008.5, -254), (0, 360, 0), "safehouse_gunshop_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25400.7, -11973.5, -254), (0, 360, 0), "safehouse_gunshop_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19551.8, -21641.2, -16), (0, 225, 0), "safehouse_1_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19615.8, -21705.2, -16), (0, 225, 0), "safehouse_1_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19583.8, -21673.2, -16), (0, 225, 0), "safehouse_1_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19511.8, -21601.2, -16), (0, 225, 0), "safehouse_1_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19471.7, -21569.2, -16), (0, 225, 0), "safehouse_1_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.origin = (19160, -21832, -16);
  var_3.targetname = "dwn_twn_safehouse_loot";
  var_3.classname = "script_model";
  var_3.model = "container_ammo_box_01_nophysics";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 315, 0);
  var_3.model = "decor_suitcase_01";
  var_3.origin = (19412, -21804.5, 19.75);
  var_3.targetname = "mission_briefcase";
  var_3.classname = "script_model";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 210, 0);
  var_3.origin = (19412.8, -21804.9, 22.5);
  var_3.target = "auto3";
  var_3.targetname = "mission_select";
  var_3.classname = "script_model";
  var_3.model = "cnd_paper_cia_01";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.origin = (19412.5, -21805.5, 21.5);
  var_3.target = "auto1";
  var_3.targetname = "mission_select_folder";
  var_3.classname = "script_model";
  var_3.model = "com_office_book_beige_paper_folder";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 315, 0);
  var_3.targetname = "mlp1_safehouse_intel";
  var_3.classname = "script_model";
  var_3.model = "electronics_usb_thumb_drive";
  var_3.origin = (19448, -21780, 22);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.origin = (19192, -21800, -16);
  var_3.targetname = "dwn_twn_safehouse_loot";
  var_3.classname = "script_model";
  var_3.model = "container_ammo_box_01_nophysics";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.origin = (19136, -21856, -16);
  var_3.targetname = "dwn_twn_safehouse_loot";
  var_3.classname = "script_model";
  var_3.model = "container_ammo_box_01_nophysics";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.model = "container_ammo_box_01_nophysics";
  var_3.origin = (19120, -21880, -16);
  var_3.targetname = "dwn_twn_safehouse_loot";
  var_3.classname = "script_model";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.model = "electronics_usb_thumb_drive";
  var_3.origin = (19448, -21776, 22);
  var_3.targetname = "mlp1_safehouse_intel";
  var_3.classname = "script_model";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.targetname = "mlp1_safehouse_intel";
  var_3.classname = "script_model";
  var_3.angles = (0, 315, 0);
  var_3.model = "electronics_usb_thumb_drive";
  var_3.origin = (19452, -21772, 22);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.targetname = "mlp1_safehouse_intel";
  var_3.classname = "script_model";
  var_3.model = "electronics_usb_thumb_drive";
  var_3.origin = (19452, -21776, 22);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 0, 0);
  var_3.model = "offhand_wm_cellphone_old";
  var_3.origin = (19448, -21784, 22);
  var_3.targetname = "mlp1_safehouse_intel";
  var_3.classname = "script_model";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 135, 0);
  var_3.origin = (19456, -21773, 22);
  var_3.targetname = "mlp1_safehouse_intel";
  var_3.classname = "script_model";
  var_3.model = "offhand_wm_cellphone_old";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 120, 0);
  var_3.origin = (25721.3, -12030.7, -208);
  var_3.targetname = "gunshop_safehouse_loot";
  var_3.model = "container_ammo_box_01_nophysics";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 90, 0);
  var_3.model = "decor_suitcase_01";
  var_3.origin = (25954.4, -12113.6, -222.25);
  var_3.targetname = "mission_briefcase_gunshop";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 345, 0);
  var_3.origin = (25954.1, -12112.8, -219.5);
  var_3.target = "auto8";
  var_3.targetname = "mission_select_gunshop";
  var_3.model = "cnd_paper_cia_01";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 180, 0);
  var_3.origin = (25954.7, -12112.5, -220.5);
  var_3.target = "auto6";
  var_3.targetname = "mission_select_folder_gunshop";
  var_3.model = "com_office_book_beige_paper_folder";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 90, 0);
  var_3.targetname = "mlp1_safehouse_intel";
  var_3.model = "electronics_usb_thumb_drive";
  var_3.origin = (25939.3, -12110.2, -222);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 210, 0);
  var_3.origin = (25497, -11964.2, -235);
  var_3.targetname = "gunshop_safehouse_loot";
  var_3.model = "container_ammo_box_01_nophysics";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 255, 0);
  var_3.origin = (25692.6, -12030.7, -208);
  var_3.targetname = "gunshop_safehouse_loot";
  var_3.model = "container_ammo_box_01_nophysics";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 285, 0);
  var_3.model = "container_ammo_box_01_nophysics";
  var_3.origin = (25465.5, -11965.1, -235.5);
  var_3.targetname = "gunshop_safehouse_loot";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 135, 0);
  var_3.classname = "script_model";
  var_3.model = "electronics_usb_thumb_drive";
  var_3.origin = (25924.5, -12112, -222);
  var_3.targetname = "mlp1_safehouse_intel";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.targetname = "mlp1_safehouse_intel";
  var_3.angles = (0, 90, 0);
  var_3.model = "electronics_usb_thumb_drive";
  var_3.origin = (25918.8, -12112.1, -222);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 180, 0);
  var_3.targetname = "mlp1_safehouse_intel";
  var_3.model = "electronics_usb_thumb_drive";
  var_3.origin = (25921.7, -12109.1, -222);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 135, 0);
  var_3.model = "offhand_wm_cellphone_old";
  var_3.origin = (25938.9, -12120.7, -222);
  var_3.targetname = "mlp1_safehouse_intel";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 270, 0);
  var_3.origin = (25938.7, -12114.3, -222);
  var_3.targetname = "mlp1_safehouse_intel";
  var_3.model = "offhand_wm_cellphone_old";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 150, 0);
  var_3.model = "un_military_duffle_bag_open_04";
  var_3.origin = (25906.9, -12121.6, -221.5);
  var_3.classname = "script_model";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}