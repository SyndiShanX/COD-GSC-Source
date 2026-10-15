/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_tungsten_fasttravel.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_utility;

#namespace zm_tungsten_fasttravel;

function init() {
  clientfield::register("world", "" + #"hash_666ad912cb4541f1", 28000, 1, "int", &function_7d467651, 0, 0);
  clientfield::register("world", "" + #"hash_6601c584f23761c4", 28000, 1, "int", &function_e746b148, 0, 0);
  level.var_b41e82d4 = 1;
}

function function_7d467651(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_833e4b72(fieldname, getEnt(fieldname, "portal_fx_main_street_to_helipads", "targetname"), #"hash_1ba53d51579f933d");
    function_833e4b72(fieldname, getEnt(fieldname, "portal_fx_main_street_to_anytown_usa", "targetname"));
    function_833e4b72(fieldname, getEnt(fieldname, "portal_fx_anytown_usa_to_main_street", "targetname"));
    function_833e4b72(fieldname, getEnt(fieldname, "portal_fx_bunker_to_anytown_usa", "targetname"));
    function_833e4b72(fieldname, getEnt(fieldname, "portal_fx_observation_to_bunker", "targetname"));
    function_833e4b72(fieldname, getEnt(fieldname, "portal_fx_helipads_to_observation", "targetname"));
    return;
  }

  function_60381056(fieldname, getEnt(fieldname, "portal_fx_main_street_to_helipads", "targetname"));
  function_60381056(fieldname, getEnt(fieldname, "portal_fx_main_street_to_anytown_usa", "targetname"));
  function_60381056(fieldname, getEnt(fieldname, "portal_fx_anytown_usa_to_main_street", "targetname"));
  function_60381056(fieldname, getEnt(fieldname, "portal_fx_bunker_to_anytown_usa", "targetname"));
  function_60381056(fieldname, getEnt(fieldname, "portal_fx_observation_to_bunker", "targetname"));
  function_60381056(fieldname, getEnt(fieldname, "portal_fx_helipads_to_observation", "targetname"));
}

function function_833e4b72(localclientnum, e_portal, str_fx = #"hash_46483584aaecbb44") {
  if(!isDefined(e_portal.fx_portal)) {
    e_portal.fx_portal = playFX(localclientnum, str_fx, e_portal.origin, anglesToForward(e_portal.angles), anglestoup(e_portal.angles));
  }

  if(!isDefined(e_portal.var_a3b04735)) {
    e_portal.var_a3b04735 = e_portal playLoopSound(#"zmb_tungsten_teleporter_lp");
  }

  if(isDefined(e_portal.var_d79ee076) && e_portal.var_d79ee076 ishidden()) {
    e_portal.var_d79ee076 show();
    e_portal.var_d79ee076 pingable();
  }
}

function function_60381056(localclientnum, e_portal) {
  if(isDefined(e_portal.fx_portal)) {
    stopfx(localclientnum, e_portal.fx_portal);
    e_portal.fx_portal = undefined;
  }

  if(isDefined(e_portal.var_a3b04735)) {
    e_portal stoploopsound(e_portal.var_a3b04735);
    e_portal.var_a3b04735 = undefined;
  }

  if(isDefined(e_portal.var_d79ee076) && !e_portal.var_d79ee076 ishidden()) {
    e_portal.var_d79ee076 hide();
    e_portal.var_d79ee076 function_23a29590();
  }
}

function function_e746b148(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    function_98acc92b(localclientnum, getEnt(localclientnum, "portal_fx_helipads_to_main_street", "targetname"), #"p9_fxp_zm_portal_aether_modular_dest_amerika_to_checkpoint_from_staging", 1);
    function_98acc92b(localclientnum, getEnt(localclientnum, "portal_fx_main_street_to_helipads", "targetname"), #"hash_5c35207bb157a661");
    function_98acc92b(localclientnum, getEnt(localclientnum, "portal_fx_main_street_to_anytown_usa", "targetname"), #"p9_fxp_zm_portal_aether_modular_dest_amerika_to_anytown_from_main");
    function_98acc92b(localclientnum, getEnt(localclientnum, "portal_fx_anytown_usa_to_main_street", "targetname"), #"hash_5d6f46eb355ec1cb");
    function_98acc92b(localclientnum, getEnt(localclientnum, "portal_fx_anytown_usa_to_bunker", "targetname"), #"hash_62e92c3479ce24e2", 1);
    function_98acc92b(localclientnum, getEnt(localclientnum, "portal_fx_bunker_to_anytown_usa", "targetname"), #"p9_fxp_zm_portal_aether_modular_dest_amerika_to_anytown_from_under");
    function_98acc92b(localclientnum, getEnt(localclientnum, "portal_fx_bunker_to_observation", "targetname"), #"p9_fxp_zm_portal_aether_modular_dest_amerika_to_observation_from_under", 0, 1);
    function_98acc92b(localclientnum, getEnt(localclientnum, "portal_fx_observation_to_bunker", "targetname"), #"hash_1d67a5d0f60e1ea");
    function_98acc92b(localclientnum, getEnt(localclientnum, "portal_fx_observation_to_helipads", "targetname"), #"hash_697445b9607e9d53", 1);
    function_98acc92b(localclientnum, getEnt(localclientnum, "portal_fx_helipads_to_observation", "targetname"), #"p9_fxp_zm_portal_aether_modular_dest_amerika_to_observation_from_staging");
    a_portals = getEntArray(localclientnum, "tungsten_teleporter", "targetname");

    foreach(portal in a_portals) {
      portal pingable();
      portal zm_utility::set_compass_icon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
    }

    portal = getEnt(localclientnum, "anytown_usa_teleporter", "targetname");
    portal pingable();
    portal thread zm_utility::function_a1290dca(localclientnum, #"hash_48c296f58e75bbc7");
    portal = getEnt(localclientnum, "portal_fx_bunker_to_observation", "targetname");
    portal.var_cc1c5020 = util::spawn_model(localclientnum, #"p9_zm_gold_teleporter_b", portal.origin - (-29, 0, 65.078), portal.angles);
    portal.var_cc1c5020 hide();
    portal.var_cc1c5020 pingable();
    portal.var_cc1c5020 zm_utility::set_compass_icon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
  }
}

function function_98acc92b(localclientnum, e_portal, var_6c81b9c0, b_hide = 0, var_9e9fd78d = 0) {
  e_portal.var_d79ee076 = util::spawn_model(localclientnum, var_6c81b9c0, e_portal.origin + anglesToForward(e_portal.angles), e_portal.angles);

  if(var_9e9fd78d) {
    e_portal.var_d79ee076 pingable();
  }

  if(b_hide) {
    e_portal.var_d79ee076 hide();
  }
}