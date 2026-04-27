/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\so_hidden_so_ghillies_anim.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_props;

main() {
  add_smoking_notetracks("generic");
  add_cellphone_notetracks("generic");

  maps\_patrol_anims::main();
  maps\so_ghillies_anim::main();

  dialog();
}

dialog() {
  level.scr_radio["so_hid_ghil_rad_warning"] = "so_hid_ghil_rad_warning";

  level.scr_radio["so_hid_ghil_sniper_hint"] = "so_hid_ghil_sniper_hint";

  level.scr_radio["so_hid_ghil_patrol_hint"] = "so_hid_ghil_patrol_hint";

  level.scr_radio["so_hid_ghil_pri_attractattn"] = "so_hid_ghil_pri_attractattn";

  level.scr_radio["so_hid_ghil_goodnight"] = "so_hid_ghil_goodnight";

  level.scr_radio["so_hid_ghil_beautiful"] = "so_hid_ghil_beautiful";

  level.scr_radio["so_hid_ghil_perfect"] = "so_hid_ghil_perfect";

  level.scr_radio["so_hid_ghil_tango_down"] = "so_hid_ghil_tango_down";

  level.scr_radio["so_hid_ghil_hesdown"] = "so_hid_ghil_hesdown";

  level.scr_radio["so_hid_ghil_neutralized"] = "so_hid_ghil_neutralized";

  level.scr_radio["so_hid_ghil_sloppy"] = "so_hid_ghil_sloppy";

  level.scr_radio["so_hid_ghil_noisy"] = "so_hid_ghil_noisy";

  level.scr_radio["so_hid_ghil_do_better"] = "so_hid_ghil_do_better";

  level.scr_radio["so_hid_ghil_double_kill"] = "so_hid_ghil_double_kill";

  level.scr_radio["so_hid_ghil_triple_kill"] = "so_hid_ghil_triple_kill";
}