/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_zm_ai_avogadro.csc
***********************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\_visionset_mgr;

init() {
  clientscripts\mp\_visionset_mgr::vsmgr_register_overlay_info_style_electrified("zm_ai_avogadro_electrified", 1, 15, 1);
}