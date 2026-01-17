/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\bonuszm\_bonuszm_util.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_load;
#using scripts\cp\_oed;
#using scripts\cp\_util;
#using scripts\cp\bonuszm\_bonuszm_data;
#using scripts\cp\bonuszm\_bonuszm_dev;
#using scripts\cp\bonuszm\_bonuszm_magicbox;
#using scripts\cp\bonuszm\_bonuszm_spawner_shared;
#using scripts\cp\bonuszm\_bonuszm_util;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_tactical_rig;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_globallogic_player;
#using scripts\shared\_oob;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ammo_shared;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\clientids_shared;
#using scripts\shared\containers_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\load_shared;
#using scripts\shared\math_shared;
#using scripts\shared\music_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\serverfaceanim_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\tweakables_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\weapons_shared;
#namespace namespace_37cacec1;

function function_5e408c24(origin, region, minradius, maxradius) {
  nodes = getnodesinradius(origin, maxradius, minradius);
  var_54f3a637 = [];
  foreach(node in nodes) {
    if(isDefined(region)) {
      var_dd83e145 = getnoderegion(node);
      if(isDefined(var_dd83e145) && region == var_dd83e145) {
        array::add(var_54f3a637, node);
      }
      continue;
    }
    array::add(var_54f3a637, node);
  }
  gotonode = array::random(var_54f3a637);
  return gotonode;
}

function function_165bd27a(health) {
  assert(isDefined(health));
  scalar = 1;
  if(isDefined(level.currentdifficulty)) {
    switch (level.currentdifficulty) {
      case "easy": {
        scalar = level.var_a9e78bf7["zombiehealthscale1"];
        break;
      }
      case "normal": {
        scalar = level.var_a9e78bf7["zombiehealthscale2"];
        break;
      }
      case "hardened": {
        scalar = level.var_a9e78bf7["zombiehealthscale3"];
        break;
      }
      case "veteran": {
        scalar = level.var_a9e78bf7["zombiehealthscale4"];
        break;
      }
      case "realistic": {
        scalar = level.var_a9e78bf7["zombiehealthscale5"];
        break;
      }
    }
  }
  return int(health * scalar);
}

function function_5f2c4513() {
  scalar = 1;
  if(isDefined(level.activeplayers)) {
    switch (level.activeplayers.size) {
      case 1: {
        scalar = level.var_a9e78bf7["extrazombiescale1"];
        break;
      }
      case 2: {
        scalar = level.var_a9e78bf7["extrazombiescale2"];
        break;
      }
      case 3: {
        scalar = level.var_a9e78bf7["extrazombiescale3"];
        break;
      }
      case 4: {
        scalar = level.var_a9e78bf7["extrazombiescale4"];
        break;
      }
    }
  }
  assert(isDefined(level.var_a9e78bf7[""]));
  return int(level.var_a9e78bf7["extraspawns"] * scalar);
}

function function_9cb5d4c9() {
  level.var_3a7fa0a9 = [];
  array::add(level.var_3a7fa0a9, "cin_gen_traversal_zipline_enemy01_attach");
  array::add(level.var_3a7fa0a9, "cin_gen_traversal_zipline_enemy01_death");
  array::add(level.var_3a7fa0a9, "cin_gen_traversal_zipline_enemy01_dismount");
  array::add(level.var_3a7fa0a9, "cin_gen_traversal_zipline_enemy01_idle");
  array::add(level.var_3a7fa0a9, "cin_gen_traversal_zipline_enemy02_attach");
  array::add(level.var_3a7fa0a9, "cin_gen_traversal_zipline_enemy02_death");
  array::add(level.var_3a7fa0a9, "cin_gen_traversal_zipline_enemy02_dismount");
  array::add(level.var_3a7fa0a9, "cin_gen_traversal_zipline_enemy02_idle");
  array::add(level.var_3a7fa0a9, "ch_sgen_11_01_silofloor_aie_dropdown_robot02_2ndfloor");
  array::add(level.var_3a7fa0a9, "ch_sgen_11_01_silofloor_aie_dropdown_robot01_3rdfloor");
  array::add(level.var_3a7fa0a9, "ch_sgen_12_02_corvus_aie_192jump");
  array::add(level.var_3a7fa0a9, "ch_gen_aie_robot_jumpdown_444");
  array::add(level.var_3a7fa0a9, "ch_sgen_18_01_pallasfight_aie_jumpdown_robot01");
}

function function_51828ce6() {
  if(!self isinscriptedstate()) {
    return false;
  }
  if(isDefined(self.current_scene) && isstring(self.current_scene)) {
    if(isinarray(level.var_3a7fa0a9, self.current_scene)) {
      return true;
    }
  }
  if(level.script === "cp_mi_sing_sgen") {
    if(isDefined(self.traversestartnode) && isDefined(self.traversestartnode.animscript) && isstring(self.traversestartnode.animscript)) {
      if(isinarray(level.var_3a7fa0a9, self.traversestartnode.animscript)) {
        return true;
      }
    }
  }
  return false;
}

function function_ce6a97e6() {
  mapname = getdvarstring("mapname");
  return self getdstat("PlayerStatsByMap", mapname + "_nightmares", "hasBeenCompleted");
}

function function_d68296ac() {
  mapname = getdvarstring("mapname");
  if(mapname == "cp_mi_eth_prologue") {
    if(isDefined(level.current_skipto) && level.current_skipto == "skipto_hangar") {
      level flag::wait_till_all(array("plane_hangar_hendricks_ready_flag", "plane_hangar_khalil_ready_flag", "plane_hangar_minister_ready_flag"));
      wait(4);
    }
  }
  if(mapname == "cp_mi_cairo_ramses") {
    if(isDefined(level.current_skipto) && level.current_skipto == "defend_ramses_station") {
      level flag::wait_till("raps_intro_done");
    }
  }
}

function function_ec036ed3(var_28b84d73, var_14e6a7e9, var_df4e4d0f) {
  if(!isDefined(level.var_5e64ddb4)) {
    level.var_5e64ddb4 = [];
    level.var_3494f35e = 0;
  }
  closestplayer = arraygetclosest(var_14e6a7e9, level.activeplayers);
  if(!isDefined(closestplayer)) {
    return var_14e6a7e9;
  }
  playerforward = anglesToForward(closestplayer.angles);
  var_2d1236a = closestplayer.origin;
  var_2d1236a = getclosestpointonnavmesh(var_2d1236a, randomintrange(100, 300));
  if(isDefined(var_2d1236a)) {
    queryresult = positionquery_source_navigation(var_2d1236a, 450, randomintrange(800, 1200), 70, randomintrange(80, 150), self);
  }
  if(!isDefined(queryresult)) {
    var_2d1236a = closestplayer.origin;
    if(isDefined(var_2d1236a)) {
      queryresult = positionquery_source_navigation(var_2d1236a, 150, randomintrange(800, 1200), 70, randomintrange(80, 150), self);
    }
  }
  var_59b020a9 = undefined;
  if(isDefined(queryresult) && queryresult.data.size > 0) {
    foreach(data in queryresult.data) {
      data.score = 0;
      var_dcf3b4e8 = function_1f637867(var_28b84d73, closestplayer, data);
      data.score = data.score + var_dcf3b4e8;
      var_8fb5ce54 = function_ae0beba6(var_28b84d73, closestplayer, data);
      data.score = data.score + var_8fb5ce54;
      var_6a9c89c0 = function_d789e857(var_28b84d73, closestplayer, data);
      data.score = data.score + var_6a9c89c0;
      var_77f56330 = function_fb8e7615(var_28b84d73, closestplayer, data);
      data.score = data.score - var_77f56330;
      if(!isDefined(var_59b020a9)) {
        var_59b020a9 = data;
      }
      if(data.score > var_59b020a9.score) {
        record3dtext(((((((((("" + data.score) + "") + var_dcf3b4e8) + "") + var_8fb5ce54) + "") + var_6a9c89c0) + "") + var_77f56330) + "", data.origin, (0, 0, 1), "");
        var_59b020a9 = data;
        continue;
      }
      record3dtext(((((((((("" + data.score) + "") + var_dcf3b4e8) + "") + var_8fb5ce54) + "") + var_6a9c89c0) + "") + var_77f56330) + "", data.origin, (1, 0, 0), "");
    }
  }
  function_4d084a77();
  if(isDefined(var_59b020a9)) {
    record3dtext("" + var_59b020a9.score, var_59b020a9.origin + vectorscale((0, 0, 1), 20), (0, 1, 0), "");
    var_42322402 = var_59b020a9.origin;
  }
  if(!isDefined(var_42322402)) {
    gotonode = function_5e408c24(var_14e6a7e9, var_df4e4d0f, 100, randomintrange(600, 1000));
    if(isDefined(gotonode)) {
      var_42322402 = gotonode.origin;
    }
  }
  if(!isDefined(var_42322402)) {
    var_42322402 = var_14e6a7e9;
  }
  if(level.var_3494f35e > 10) {
    level.var_3494f35e = 0;
  }
  level.var_5e64ddb4[level.var_3494f35e] = var_42322402;
  level.var_3494f35e++;
  return var_42322402;
}

function function_1f637867(var_28b84d73, closestplayer, data) {
  score = 0;
  foreach(player in level.activeplayers) {
    var_5734b0ef = distancesquared(data.origin, player.origin);
    var_d322d6e7 = math::clamp(var_5734b0ef, 0, 1200 * 1200);
    score = score + (var_d322d6e7 / (1200 * 1200));
    if(var_5734b0ef > (1200 * 1200)) {
      score = score + (randomfloatrange(-0.1, 0.1));
    }
  }
  return score;
}

function function_ae0beba6(var_28b84d73, closestplayer, data) {
  score = 0;
  var_4d45bcdc = 0;
  if(isDefined(closestplayer) && isDefined(closestplayer.v_current_active_breadcrumb)) {
    var_c54cd263 = vectornormalize((closestplayer.v_current_active_breadcrumb[0], closestplayer.v_current_active_breadcrumb[1], 0) - (closestplayer.origin[0], closestplayer.origin[1], 0));
    fov = cos(70);
    var_a9f2c7c7 = vectornormalize((data.origin[0], data.origin[1], 0) - (closestplayer.origin[0], closestplayer.origin[1], 0));
    dot = vectordot(var_c54cd263, var_a9f2c7c7);
    if(dot >= fov) {
      score = randomfloatrange(1, 2);
    }
  }
  return score;
}

function function_d789e857(var_28b84d73, closestplayer, data) {
  assert(isDefined(var_28b84d73));
  score = 1;
  if(var_28b84d73 isposinclaimedlocation(data.origin)) {
    score = 0;
  }
  return score;
}

function function_fb8e7615(var_28b84d73, closestplayer, data) {
  score = 0;
  foreach(location in level.var_5e64ddb4) {
    var_b0035858 = distancesquared(location, data.origin);
    if(var_b0035858 <= (120 * 120)) {
      score = score + ((1 - (var_b0035858 / (120 * 120))) * 0.2);
    }
  }
  return score;
}

function function_4d084a77() {
  foreach(location in level.var_5e64ddb4) {
    recordsphere(location, 4, (1, 1, 0), "");
  }
}