/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_downtown_cs.gsc
***************************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_donetsk_safehouse_downtown_cs")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_donetsk_safehouse_downtown_cs");
  var2 = spawnStruct();
  thread cs_return_and_wait_for_flag(level, var0, var1, var2);

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime()) {
    scripts\cp\cp_create_script_utility::endcreatescript(var2);
    return;
  }
}

function cs_return_and_wait_for_flag(var0, var1, var2, var3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var3);

  if(!isDefined(var1)) {
    var1 = "stk";
  }

  var2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var1, "cp_donetsk_safehouse_downtown_cs");
  scripts\cp\cp_create_script_utility::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);
  thread createmodels(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_donetsk_safehouse_downtown_cs");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_donetsk_safehouse_downtown_cs");
}

function createstructs(var0, var1, var2) {
  var3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19418, -21800.8, 34.5), (0, 0, 0), "auto1", "auto2", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19251, -22137, 22.25), (0, 315, 0), "dwn_twn_safehouse_gate", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19432, -21791.5, 21.5), (0, 135, 0), "auto4", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19074.5, -21925.5, 36.75), (0, 315, 0), "dwn_twn_safehouse_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19431, -21792, 20.5), (0, 330, 0), "auto2", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19418, -21800.8, 34.5), (0, 0, 0), "auto3", "auto4", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (25947.5, -12112, -207.5), (0, 135, 0), "auto6", "auto5", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (25931.3, -12112.7, -221.25), (0, 270, 0), "auto7", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (25910.9, -11979.1, -209.75), (0, 225, 0), "gunshop_safehouse_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (25932.3, -12112.9, -222), (0, 105, 0), "auto5", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (25947.5, -12112, -207.5), (0, 135, 0), "auto8", "auto7", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (25398.5, -12041.1, -254), (0, 360, 0), "safehouse_gunshop_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (25398.5, -12078.3, -254), (0, 360, 0), "safehouse_gunshop_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (25398.5, -12008.5, -254), (0, 360, 0), "safehouse_gunshop_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (25400.7, -11973.5, -254), (0, 360, 0), "safehouse_gunshop_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19551.8, -21641.2, -16), (0, 225, 0), "safehouse_1_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19615.8, -21705.2, -16), (0, 225, 0), "safehouse_1_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19583.8, -21673.2, -16), (0, 225, 0), "safehouse_1_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19511.8, -21601.2, -16), (0, 225, 0), "safehouse_1_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19471.7, -21569.2, -16), (0, 225, 0), "safehouse_1_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var0, var1, var2) {
  var3 = spawnStruct();
  var3.angles = (0, 45, 0);
  var3.origin = (19160, -21832, -16);
  var3.targetname = "dwn_twn_safehouse_loot";
  var3.classname = "script_model";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 315, 0);
  var3.model = "decor_suitcase_01";
  var3.origin = (19412, -21804.5, 19.75);
  var3.targetname = "mission_briefcase";
  var3.classname = "script_model";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 210, 0);
  var3.origin = (19412.8, -21804.9, 22.5);
  var3.target = "auto3";
  var3.targetname = "mission_select";
  var3.classname = "script_model";
  var3.model = "cnd_paper_cia_01";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 45, 0);
  var3.origin = (19412.5, -21805.5, 21.5);
  var3.target = "auto1";
  var3.targetname = "mission_select_folder";
  var3.classname = "script_model";
  var3.model = "com_office_book_beige_paper_folder";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 315, 0);
  var3.targetname = "mlp1_safehouse_intel";
  var3.classname = "script_model";
  var3.model = "electronics_usb_thumb_drive";
  var3.origin = (19448, -21780, 22);
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 45, 0);
  var3.origin = (19192, -21800, -16);
  var3.targetname = "dwn_twn_safehouse_loot";
  var3.classname = "script_model";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 45, 0);
  var3.origin = (19136, -21856, -16);
  var3.targetname = "dwn_twn_safehouse_loot";
  var3.classname = "script_model";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 45, 0);
  var3.model = "container_ammo_box_01_nophysics";
  var3.origin = (19120, -21880, -16);
  var3.targetname = "dwn_twn_safehouse_loot";
  var3.classname = "script_model";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.model = "electronics_usb_thumb_drive";
  var3.origin = (19448, -21776, 22);
  var3.targetname = "mlp1_safehouse_intel";
  var3.classname = "script_model";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.targetname = "mlp1_safehouse_intel";
  var3.classname = "script_model";
  var3.angles = (0, 315, 0);
  var3.model = "electronics_usb_thumb_drive";
  var3.origin = (19452, -21772, 22);
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 45, 0);
  var3.targetname = "mlp1_safehouse_intel";
  var3.classname = "script_model";
  var3.model = "electronics_usb_thumb_drive";
  var3.origin = (19452, -21776, 22);
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 0, 0);
  var3.model = "offhand_wm_cellphone_old";
  var3.origin = (19448, -21784, 22);
  var3.targetname = "mlp1_safehouse_intel";
  var3.classname = "script_model";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 135, 0);
  var3.origin = (19456, -21773, 22);
  var3.targetname = "mlp1_safehouse_intel";
  var3.classname = "script_model";
  var3.model = "offhand_wm_cellphone_old";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 120, 0);
  var3.origin = (25721.3, -12030.7, -208);
  var3.targetname = "gunshop_safehouse_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 90, 0);
  var3.model = "decor_suitcase_01";
  var3.origin = (25954.4, -12113.6, -222.25);
  var3.targetname = "mission_briefcase_gunshop";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 345, 0);
  var3.origin = (25954.1, -12112.8, -219.5);
  var3.target = "auto8";
  var3.targetname = "mission_select_gunshop";
  var3.model = "cnd_paper_cia_01";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 180, 0);
  var3.origin = (25954.7, -12112.5, -220.5);
  var3.target = "auto6";
  var3.targetname = "mission_select_folder_gunshop";
  var3.model = "com_office_book_beige_paper_folder";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 90, 0);
  var3.targetname = "mlp1_safehouse_intel";
  var3.model = "electronics_usb_thumb_drive";
  var3.origin = (25939.3, -12110.2, -222);
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 210, 0);
  var3.origin = (25497, -11964.2, -235);
  var3.targetname = "gunshop_safehouse_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 255, 0);
  var3.origin = (25692.6, -12030.7, -208);
  var3.targetname = "gunshop_safehouse_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 285, 0);
  var3.model = "container_ammo_box_01_nophysics";
  var3.origin = (25465.5, -11965.1, -235.5);
  var3.targetname = "gunshop_safehouse_loot";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 135, 0);
  var3.classname = "script_model";
  var3.model = "electronics_usb_thumb_drive";
  var3.origin = (25924.5, -12112, -222);
  var3.targetname = "mlp1_safehouse_intel";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.targetname = "mlp1_safehouse_intel";
  var3.angles = (0, 90, 0);
  var3.model = "electronics_usb_thumb_drive";
  var3.origin = (25918.8, -12112.1, -222);
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 180, 0);
  var3.targetname = "mlp1_safehouse_intel";
  var3.model = "electronics_usb_thumb_drive";
  var3.origin = (25921.7, -12109.1, -222);
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 135, 0);
  var3.model = "offhand_wm_cellphone_old";
  var3.origin = (25938.9, -12120.7, -222);
  var3.targetname = "mlp1_safehouse_intel";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 270, 0);
  var3.origin = (25938.7, -12114.3, -222);
  var3.targetname = "mlp1_safehouse_intel";
  var3.model = "offhand_wm_cellphone_old";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.angles = (0, 150, 0);
  var3.model = "un_military_duffle_bag_open_04";
  var3.origin = (25906.9, -12121.6, -221.5);
  var3.classname = "script_model";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}