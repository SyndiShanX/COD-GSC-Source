/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\ultimate_turret_shared.csc
**************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace ultimate_turret;

function init_shared() {
  if(!isDefined(level.var_1427245)) {
    level.var_1427245 = {};
    clientfield::register("vehicle", "ultimate_turret_open", 1, 1, "int", &turret_open, 0, 0);
    clientfield::register("vehicle", "ultimate_turret_init", 1, 1, "int", &turret_init_anim, 0, 0);
    clientfield::register("vehicle", "ultimate_turret_close", 1, 1, "int", &turret_close_anim, 0, 0);
    clientfield::register_clientuimodel("hudItems.ultimateTurretCount", #"hud_items", #"ultimateturretcount", 1, 3, "int", undefined, 0, 0);
  }
}

function turret_init_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bwastimejump) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(fieldname);
  self useanimtree("generic");
  self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
  self setanimtime(#"o_turret_mini_deploy", 0);
}

function turret_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bwastimejump) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(fieldname);
  self useanimtree("generic");
  self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
}

function turret_close_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}