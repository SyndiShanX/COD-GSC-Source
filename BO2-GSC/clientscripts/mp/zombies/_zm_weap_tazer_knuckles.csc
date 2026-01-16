/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_zm_weap_tazer_knuckles.csc
***************************************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_fx;
#include clientscripts\mp\_music;

init() {
  registerclientfield("toplayer", "tazer_flourish", 1, 1, "int", ::tazer_flourish, 0);

  if(getdvar(#"createfx") == "on") {
    return;
  }
  level._effect["fx_zmb_taser_flourish"] = loadfx("weapon/taser/fx_taser_knuckles_anim_zmb");
}

tazer_flourish(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval)
    playviewmodelfx(localclientnum, level._effect["fx_zmb_taser_flourish"], "tag_weapon");
}