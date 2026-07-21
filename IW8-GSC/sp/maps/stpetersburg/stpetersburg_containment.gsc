/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_containment.gsc
*************************************************************/

containment_init() {
  scripts\engine\utility::flag_init("flag_start_alley_containment");
  scripts\engine\utility::flag_init("flag_start_bar_backroom_containment");
  scripts\engine\utility::flag_init("flag_start_bar_street_containment");
  scripts\engine\utility::flag_init("flag_start_apartment_containment");
  scripts\engine\utility::flag_init("flag_start_canal_containment");
  scripts\engine\utility::flag_init("flag_start_acquire_containment");
  scripts\engine\utility::flag_init("flag_start_escort_containment");
  scripts\engine\utility::flag_init("flag_start_gauntlet_containment");
  scripts\engine\utility::flag_init("flag_end_player_wander_fail");
}

containment_start() {
  wait 1.0;
  thread alley_containment();
  thread bar_containment();
  thread bar_street_containment();
  thread apartment_containment();
  thread canal_containment();
  thread acquire_containment();
  thread escort_containment();
  thread gauntlet_containment();
}

alley_containment() {
  scripts\engine\utility::flag_wait("flag_start_alley_containment");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_wander_fail_volume("containment_alley");
}

bar_containment() {
  scripts\engine\utility::flag_wait("flag_start_bar_backroom_containment");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_wander_fail_volume("containment_bar_back");
}

bar_street_containment() {
  scripts\engine\utility::flag_wait("flag_start_bar_street_containment");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_wander_fail_volume("containment_bar_street");
}

apartment_containment() {
  scripts\engine\utility::flag_wait("flag_start_apartment_containment");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_wander_fail_volume("containment_apartment");
}

canal_containment() {
  scripts\engine\utility::flag_wait("flag_start_canal_containment");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_wander_fail_volume("containment_canal");
}

acquire_containment() {
  scripts\engine\utility::flag_wait("flag_start_acquire_containment");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_wander_fail_volume("containment_acquire");
}

escort_containment() {
  scripts\engine\utility::flag_wait("flag_start_escort_containment");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_wander_fail_volume("containment_escort");
}

gauntlet_containment() {
  scripts\engine\utility::flag_wait("flag_start_gauntlet_containment");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_wander_fail_volume("containment_gauntlet");
}