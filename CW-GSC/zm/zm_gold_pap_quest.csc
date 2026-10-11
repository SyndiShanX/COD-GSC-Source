/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_gold_pap_quest.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_ping;
#using scripts\zm_common\zm_utility;
#namespace zm_gold_pap_quest;

function init() {
  clientfield::register("world", "" + #"hash_666ad912cb4541f1", 16000, 1, "int", &function_7d467651, 0, 0);
  clientfield::register("world", "" + #"hash_18c31f1201f7c968", 16000, 1, "counter", &function_e4ea3f5f, 0, 0);
  clientfield::register("world", "" + #"teleporter_minimap", 16000, 1, "counter", &teleporter_minimap, 0, 0);
  zm_ping::function_5ae4a10c(undefined, "gold_teleporter", #"hash_4046a68ee9d717fc", undefined, #"ui_hud_minimap_teleporter");
}

function function_7d467651(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    var_73524bb4 = getEntArray(fieldname, "portal_fx", "targetname");

    foreach(portal_pos in var_73524bb4) {
      portal_pos.fx_portal = playFX(fieldname, #"hash_3af1d592cda71a5c", portal_pos.origin, anglesToForward(portal_pos.angles), anglestoup(portal_pos.angles));

      if(!isDefined(portal_pos.var_a3b04735)) {
        portal_pos.var_a3b04735 = portal_pos playLoopSound(#"zmb_gold_teleporter_lp");
      }
    }

    return;
  }

  var_73524bb4 = getEntArray(fieldname, "portal_fx", "targetname");

  foreach(portal_pos in var_73524bb4) {
    stopfx(fieldname, portal_pos.fx_portal);
    portal_pos.fx_portal = undefined;

    if(isDefined(portal_pos.var_a3b04735)) {
      portal_pos stoploopsound(portal_pos.var_a3b04735);
      portal_pos.var_a3b04735 = undefined;
    }
  }
}

function function_e4ea3f5f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  teleporters = getEntArray(bwasdemojump, "gold_teleporter", "targetname");

  foreach(teleporter in teleporters) {
    teleporter pingable();
    teleporter.var_fc558e74 = "gold_teleporter";
  }
}

function teleporter_minimap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  foreach(var_1da0aee8 in getEntArray(localclientnum, "gold_teleporter", "targetname")) {
    var_1da0aee8 zm_utility::set_compass_icon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
  }
}