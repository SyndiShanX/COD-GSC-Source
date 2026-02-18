/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\globallogic_player.csc
******************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace globallogic_player;

function private autoexec __init__system__() {
  system::register(#"globallogic_player", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "player_damage_type", 1, 1, "int", &player_damage_type_changed, 0, 0);
}

function player_damage_type_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self function_21c0fa55()) {
    return;
  }

  if(bwastimejump) {
    self setdamagedirectionindicator(1);
    setsoundcontext("plr_impact", "flesh");
    return;
  }

  self setdamagedirectionindicator(0);
  setsoundcontext("plr_impact", "flesh");
}