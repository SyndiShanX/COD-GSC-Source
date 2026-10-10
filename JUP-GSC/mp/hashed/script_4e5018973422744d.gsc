/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4e5018973422744d.gsc
*************************************************/

#using script_511dbb84a7b7553e;
#using script_699beeb185d284d2;
#using scripts\engine\utility;
#namespace namespace_1ce334f4612dc1ae;

function function_c93b23bb9922f962(starlevel, func) {
  if(!isDefined(level.var_71db77525c208a0f)) {
    level.var_71db77525c208a0f = [];
  }

  struct = spawnStruct();
  struct.starlevel = array_find([3, 5, 7, 12, 20], starlevel) + 1;
  struct.func = func;
  level.var_71db77525c208a0f[level.var_71db77525c208a0f.size] = struct;
}

function function_ebb47a7870bb63fb(player) {
  player = self;
  player notify("starRankAquired");

  if(!isDefined(level.var_71db77525c208a0f)) {
    return;
  }

  starlevel = self.var_94908079eda0edb0;

  foreach(struct in level.var_71db77525c208a0f) {
    if(starlevel != struct.starlevel) {
      continue;
    }

    level thread[[struct.func]](player);
  }
}

function function_1d6b7b205b970e2e(player) {
  player notify("player_new_star_level");
  player notify("player_star_level_reset");

  if(istrue(player.var_164e5da494fefce9)) {
    player.var_164e5da494fefce9 = 0;
  }

  player.var_63ae7ddbf47f9041 = undefined;
  player.var_ae4fe1908c5a6b2a = undefined;
  player hudoutlinedisable();
  player setthreatbiasgroup("limbo_ai_threat_bias_0");
  player unsetperk("specialty_radarblip", 0);
}

function function_28cfcb99965e96dc(player) {
  player.var_ed665b140e92c2af = 0;
}

function function_e452c990ed15f1f4(player) {
  player endon("disconnect");
  player endon("player_new_star_level");

  while(true) {
    if(player.var_94908079eda0edb0 != 1) {
      return;
    }

    pinglocationenemyteams(player.origin, player.team, player);
    wait 10;
  }
}

function function_716ff25a947c0f33(player) {
  player endon("death_or_disconnect");
  player endon("player_star_level_reset");

  if(istrue(player.var_164e5da494fefce9)) {
    return;
  }

  if(isDefined(player.var_79112e6dfcc646cf) && player.var_79112e6dfcc646cf.size > 0) {
    foreach(agent in player.var_79112e6dfcc646cf) {
      if(isalive(agent) && !istrue(agent.var_781b08d0fe970ef6)) {
        return;
      }
    }
  }

  player.var_79112e6dfcc646cf = undefined;
  player.var_164e5da494fefce9 = 1;

  while(true) {
    success = namespace_bf4d47cca9186faa::function_a76a168ff45403d0(3, player);

    if(success) {
      break;
    }

    wait 1;
  }

  player.var_164e5da494fefce9 = 0;
}

function function_c2a7489563a6adc3(player) {
  player endon("disconnect");
  player endon("player_new_star_level");

  while(true) {
    if(player.var_94908079eda0edb0 != 2) {
      return;
    }

    pinglocationenemyteams(player.origin, player.team, player);
    wait 5;
  }
}

function function_1adc246b5aa124de(player) {
  player setperk("specialty_radarblip", 1);
}

function function_61ecfe68e049247d(player) {
  triggerportableradarpingteam(player.origin, player.team, 1, 1, 6);
}

function function_de423ea0fb5966b8(player) {
  if(isDefined(level.var_ef0dad85a40b1807)) {
    return;
  }

  if(isDefined(level.var_33208cc9a89d1a0d)) {
    level thread[[level.var_33208cc9a89d1a0d]]();
  }
}

function function_3f4a3832eae83768(player) {
  player hudoutlineenable("outline_nodepth_red");
}

function function_ab74507383cbf2f2(player) {
  player namespace_83b142ab0b1210c0::function_bdf7f1777331997d("limbo_ai_threat_bias_1");
}

function function_9fa0452210d65aa1(player) {
  player namespace_83b142ab0b1210c0::function_bdf7f1777331997d("limbo_ai_threat_bias_2");
}

function function_9fa0442210d6586e(player) {
  player namespace_83b142ab0b1210c0::function_bdf7f1777331997d("limbo_ai_threat_bias_3");
}

function function_9fa0472210d65f07(player) {
  player namespace_83b142ab0b1210c0::function_bdf7f1777331997d("limbo_ai_threat_bias_4");
}

function function_9fa0462210d65cd4(player) {
  level thread function_de423ea0fb5966b8(player);
  player namespace_83b142ab0b1210c0::function_bdf7f1777331997d("limbo_ai_threat_bias_5");
}