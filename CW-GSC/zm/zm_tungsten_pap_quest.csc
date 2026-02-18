/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_tungsten_pap_quest.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_tungsten_fasttravel;
#namespace zm_tungsten_pap_quest;

function init() {
  clientfield::register("world", "" + # "hash_2c7fb1cc66c590a0", 28000, getminbitcountfornum(2), "int", &function_68bbfe, 0, 0);
  clientfield::register("world", "" + # "hash_18f96dcb4766fbe8", 28000, 1, "int", &function_34eb3249, 0, 0);
  clientfield::register("world", "" + # "hash_45c3013f063fe2c7", 28000, getminbitcountfornum(2), "int", &function_2d49baf, 0, 0);
  clientfield::register("world", "" + # "hash_3432d09ff93c9a0c", 28000, 1, "int", &function_794730f, 0, 0);
  clientfield::register("world", "" + # "hash_27308a7dd991ce8d", 28000, 1, "int", &function_8c88a649, 0, 0);
  clientfield::register("actor", "" + # "hash_54e2a4e02a26cc62", 28000, 1, "counter", &function_95190421, 0, 0);
  clientfield::register("world", "" + # "hash_12eb39113e9737f8", 28000, 1, "int", &function_1446ef30, 0, 0);
}

function function_68bbfe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  e_portal = getent(fieldname, "portal_fx_helipads_to_main_street", "targetname");

  if(bwasdemojump) {
    if(bwasdemojump == 1) {
      function_d93b0fff(fieldname, e_portal);
    } else {
      function_1f88d6(fieldname, e_portal);
      function_7e3966f(fieldname, e_portal);
    }

    return;
  }

  function_1f88d6(fieldname, e_portal);
}

function function_1446ef30(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel(#"p9_zm_gold_teleporter_b");
    return;
  }

  stopforcestreamingxmodel(#"p9_zm_gold_teleporter_b");
}

function function_34eb3249(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  level endon(#"end_game");
  e_portal = getent(fieldname, "portal_fx_anytown_usa_to_bunker", "targetname");

  if(bwasdemojump) {
    var_1da0aee8 = getent(fieldname, "anytown_usa_teleporter", "targetname");

    if(var_1da0aee8.model !== # "p9_zm_gold_teleporter_b") {
      var_1da0aee8 setModel(#"p9_zm_gold_teleporter_b");
    }

    function_d93b0fff(fieldname, e_portal);
    wait 1.5;

    if(isDefined(e_portal.var_bd434ca)) {
      stopfx(fieldname, e_portal.var_bd434ca);
      e_portal.var_bd434ca = undefined;
      namespace_ff7e490::function_60381056(fieldname, e_portal);
      function_7e3966f(fieldname, e_portal);
    }

    return;
  }

  function_1f88d6(fieldname, e_portal);
}

function function_8c88a649(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  e_portal = getent(fieldname, "portal_dmg_spark_fx", "targetname");

  if(bwasdemojump) {
    if(!isDefined(e_portal.fx_portal)) {
      e_portal.fx_portal = playFX(fieldname, #"hash_532aade47be565ff", e_portal.origin, anglesToForward(e_portal.angles), anglestoup(e_portal.angles));
    }

    return;
  }

  if(isDefined(e_portal.fx_portal)) {
    stopfx(fieldname, e_portal.fx_portal);
    e_portal.fx_portal = undefined;
  }
}

function function_2d49baf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  e_portal = getent(fieldname, "portal_fx_bunker_to_observation", "targetname");

  if(bwasdemojump) {
    if(bwasdemojump == 1) {
      namespace_ff7e490::function_60381056(fieldname, e_portal);
      e_portal playSound(fieldname, #"hash_347114806e46c42a");
      namespace_ff7e490::function_833e4b72(fieldname, e_portal);
    } else {
      namespace_ff7e490::function_60381056(fieldname, e_portal);
      e_portal.fx_portal = playFX(fieldname, #"hash_9d2f5030c333b16", e_portal.origin, anglesToForward(e_portal.angles), anglestoup(e_portal.angles));
      e_portal.var_a3b04735 = e_portal playLoopSound(#"hash_83b5ecd7e3f8f29");
      e_portal playSound(fieldname, #"hash_740416d5474f1ce7");
    }

    return;
  }

  namespace_ff7e490::function_60381056(fieldname, e_portal);
}

function function_794730f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  level endon(#"end_game");
  e_portal = getent(fieldname, "portal_fx_observation_to_helipads", "targetname");

  if(bwasdemojump == 1) {
    function_d93b0fff(fieldname, e_portal);
    wait 1.5;

    if(isDefined(e_portal.var_bd434ca)) {
      stopfx(fieldname, e_portal.var_bd434ca);
      e_portal.var_bd434ca = undefined;
      namespace_ff7e490::function_60381056(fieldname, e_portal);
      function_7e3966f(fieldname, e_portal);
    }

    return;
  }

  function_1f88d6(fieldname, e_portal);
}

function private function_d93b0fff(localclientnum, e_portal) {
  if(!isDefined(e_portal.fx_portal)) {
    e_portal.fx_portal = playFX(localclientnum, #"hash_42ec8f4ec8bcc91b", e_portal.origin, anglesToForward(e_portal.angles), anglestoup(e_portal.angles));
  }

  if(!isDefined(e_portal.var_bd434ca)) {
    e_portal.var_bd434ca = playFX(localclientnum, #"hash_22568d89d3063dec", e_portal.origin, anglesToForward(e_portal.angles), anglestoup(e_portal.angles));
  }

  if(!isDefined(e_portal.var_a3b04735)) {
    e_portal playSound(localclientnum, #"hash_c2c4f6486acdcd6");
    e_portal.var_a3b04735 = e_portal playLoopSound(#"hash_3a1b6a329b7e308f");
  }
}

function private function_7e3966f(localclientnum, e_portal, str_fx) {
  level endon(#"end_game");
  playFX(localclientnum, #"hash_139f53aac7315984", e_portal.origin, anglesToForward(e_portal.angles), anglestoup(e_portal.angles));
  e_portal playSound(localclientnum, #"hash_29c5f5ba6e81488c");
  wait 0.45;
  e_portal playSound(localclientnum, #"hash_1d48a1b077c9670b");
  namespace_ff7e490::function_833e4b72(localclientnum, e_portal, str_fx);
}

function private function_1f88d6(localclientnum, e_portal) {
  if(isDefined(e_portal.var_bd434ca)) {
    stopfx(localclientnum, e_portal.var_bd434ca);
    e_portal.var_bd434ca = undefined;
  }

  namespace_ff7e490::function_60381056(localclientnum, e_portal);
}

function function_95190421(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(bwastimejump, #"zombie/fx9_onslaught_spawn_sm", self.origin);
  playSound(bwastimejump, #"hash_10605de886d51283", self.origin + (0, 0, 35));
}