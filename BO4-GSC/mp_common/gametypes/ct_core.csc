/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ct_core.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\renderoverridebundle;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\ct_utils;

#namespace ct_core;

function_46e95cc7() {
  level.var_7b05c4b5 = 1;
  level.var_9f011465 = 1;
  level.var_e3049e92 = 0;
  level.var_903e2252 = 1;
}

function_fa03fc55() {
  clientfield::register("allplayers", "enemy_on_radar", 1, 1, "int", &enemy_on_radar, 0, 1);
  clientfield::register("actor", "enemy_on_radar", 1, 1, "int", &enemy_on_radar, 0, 1);
  clientfield::register("allplayers", "player_keyline_render", 1, 1, "int", &player_keyline_render, 0, 1);
  clientfield::register("allplayers", "enemy_keyline_render", 1, 1, "int", &enemy_keyline_render, 0, 1);
  clientfield::register("scriptmover", "enemyobj_keyline_render", 1, 1, "int", &enemyobj_keyline_render, 0, 0);
  clientfield::register("actor", "actor_keyline_render", 1, 1, "int", &actor_keyline_render, 0, 0);
  clientfield::register("vehicle", "enemy_vehicle_keyline_render", 1, 1, "int", &enemy_vehicle_keyline_render, 0, 0);
  clientfield::register("allplayers", "set_vip", 1, 2, "int", &set_vip, 0, 0);
  clientfield::register("scriptmover", "animate_spawn_beacon", 1, 1, "int", &animate_spawn_beacon, 0, 0);
  clientfield::register("scriptmover", "objective_glow", 1, 1, "int", &objective_glow, 0, 0);
}

player_keyline_render(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == oldval) {
    return;
  }

  if(newval && !(isDefined(self.var_a7656c04) && self.var_a7656c04)) {
    self.var_a7656c04 = 1;
    self playrenderoverridebundle(#"hash_1c90592671f4c6e9");
    return;
  }

  if(isDefined(self.var_a7656c04) && self.var_a7656c04) {
    self.var_a7656c04 = 0;
    self stoprenderoverridebundle(#"hash_1c90592671f4c6e9");
  }
}

enemy_keyline_render(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == oldval) {
    return;
  }

  if(newval && !(isDefined(self.var_a7656c04) && self.var_a7656c04)) {
    self.var_a7656c04 = 1;
    self playrenderoverridebundle(#"hash_1dced6114b72a678");
    return;
  }

  if(isDefined(self.var_a7656c04) && self.var_a7656c04) {
    self.var_a7656c04 = 0;
    self stoprenderoverridebundle(#"hash_1dced6114b72a678");
  }
}

enemyobj_keyline_render(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == oldval) {
    return;
  }

  if(newval) {
    self playrenderoverridebundle(#"hash_46b7dcb7342c64a2");
    self mapshaderconstant(localclientnum, 0, "scriptVector3", 1.5, 1, 1, 1);
    self mapshaderconstant(localclientnum, 0, "scriptVector4", 0.6, 0, 0, 0);
    return;
  }

  self stoprenderoverridebundle(#"hash_46b7dcb7342c64a2");
}

objective_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    self playrenderoverridebundle(#"rob_objective");
    return;
  }

  self stoprenderoverridebundle(#"rob_objective");
}

actor_keyline_render(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == oldval) {
    return;
  }

  if(newval) {
    self playrenderoverridebundle(#"hash_1dced6114b72a678");
    return;
  }

  self stoprenderoverridebundle(#"hash_1dced6114b72a678");
}

enemy_vehicle_keyline_render(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == oldval) {
    return;
  }

  if(newval) {
    self playrenderoverridebundle(#"rob_sonar_set_enemyequip");
    return;
  }

  self stoprenderoverridebundle(#"rob_sonar_set_enemyequip");
}

set_vip(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 2) {
    self function_79ea07a3(1);
    return;
  }

  self function_79ea07a3(0);
}

enemy_on_radar(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self enableonradar();
    return;
  }

  self disableonradar();
}

animate_spawn_beacon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrenderoverridebundle(#"rob_sonar_set_enemyequip");
    self useanimtree("generic");
    self setanimrestart(#"o_spawn_beacon_deploy", 1, 0, 1);
    return;
  }

  self stoprenderoverridebundle(#"rob_sonar_set_enemyequip");
  playFX(localclientnum, "explosions/fx_exp_dest_barrel_lg", self.origin);
}