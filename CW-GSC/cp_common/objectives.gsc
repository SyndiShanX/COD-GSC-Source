/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\objectives.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives_ui;
#namespace objectives;

function private autoexec __init__system__() {
  system::register(#"objectives", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  mission.var_c68f10d0 = [];
  mission.var_ac8e2ff9 = [];
}

function set(str_objective, a_targets, var_8c7ec5ce, var_4cfa0710 = str_objective, var_690561dc, show_splash = 1, show_waypoint = 1, var_bfcac307) {
  level flag::wait_till(#"gameplay_started");

  if(isDefined(a_targets)) {
    if(!isDefined(a_targets)) {
      a_targets = [];
    } else if(!isarray(a_targets)) {
      a_targets = array(a_targets);
    }

    if(a_targets.size > 1) {
      scripted(var_4cfa0710, undefined, var_690561dc, show_splash, var_bfcac307);
      function_1de88d60(var_4cfa0710, undefined, 0, a_targets.size);
    }

    foreach(target in a_targets) {
      n_obj_id = gameobjects::get_next_obj_id();
      var_ff48959 = target;

      if(isvec(target)) {
        mission.var_c68f10d0[var_4cfa0710] = n_obj_id;
      } else {
        if(!isDefined(target.a_n_objective_ids)) {
          target.a_n_objective_ids = [];
        }

        target.a_n_objective_ids[var_4cfa0710] = n_obj_id;

        if(!isentity(target) && isDefined(target.origin)) {
          var_ff48959 = target.origin;
        }

        if(is_true(var_8c7ec5ce) && isentity(target)) {
          target thread function_aa8c2bb2(var_4cfa0710, a_targets);
        }
      }

      objective_add(n_obj_id, "active", var_ff48959, str_objective);
      function_6da98133(n_obj_id);

      if(a_targets.size == 1) {
        if(isDefined(var_690561dc)) {
          objectives_ui::function_bfdab223(n_obj_id, var_690561dc);
          objectives_ui::set_state(n_obj_id, 0);
        }

        if(isDefined(var_bfcac307)) {
          objectives_ui::function_bacd9b1f(n_obj_id, var_bfcac307);
        }
      }

      if(show_waypoint) {
        thread objectives_ui::function_f3ac479c(n_obj_id);
      }

      objectives_ui::function_572778b9(n_obj_id, 0);
      objectives_ui::function_6a43edf3(n_obj_id, 0);
    }
  } else {
    n_obj_id = gameobjects::get_next_obj_id();
    mission.var_c68f10d0[var_4cfa0710] = n_obj_id;
    objective_add(n_obj_id, "active", (0, 0, 0), str_objective);
    function_6da98133(n_obj_id);

    if(isDefined(var_690561dc)) {
      objectives_ui::function_bfdab223(n_obj_id, var_690561dc);
      objectives_ui::set_state(n_obj_id, 0);
    }

    if(isDefined(var_bfcac307)) {
      objectives_ui::function_bacd9b1f(n_obj_id, var_bfcac307);
    }

    if(show_waypoint) {
      thread objectives_ui::function_f3ac479c(n_obj_id);
    }

    objectives_ui::function_572778b9(n_obj_id, 0);
    objectives_ui::function_6a43edf3(n_obj_id, 0);
  }

  if(show_splash && isDefined(var_690561dc)) {
    thread objectives_ui::function_8d9f9a22(n_obj_id);
    thread objectives_ui::function_1c6b4aeb();
  }

  player = getplayers()[0];

  if(isDefined(player) && show_waypoint) {
    player thread objectives_ui::show_objectives(0);
  }
}

function follow(var_4cfa0710, var_b3177bd9, var_690561dc, show_splash, show_waypoint = 0, var_c3056ba3 = # "hash_f71affaf9c403ac") {
  set(var_c3056ba3, var_b3177bd9, 1, var_4cfa0710, var_690561dc, show_splash, show_waypoint);
}

function kill(var_4cfa0710, var_3829dccf, var_690561dc, show_splash, show_waypoint, var_bfcac307, var_c3056ba3 = # "hash_5c90265e62b1f975") {
  set(var_c3056ba3, var_3829dccf, 1, var_4cfa0710, var_690561dc, show_splash, show_waypoint, var_bfcac307);
}

function area(var_4cfa0710, var_8343acf6, radius, var_690561dc, show_splash, show_waypoint, var_bfcac307, var_c3056ba3 = # "hash_4a026a0a4473d478") {
  set(var_c3056ba3, undefined, 0, var_4cfa0710, var_690561dc, show_splash, show_waypoint, var_bfcac307);

  if(isentity(var_8343acf6)) {
    update_position(var_4cfa0710, var_8343acf6.origin);
  } else {
    update_position(var_4cfa0710, var_8343acf6);
  }

  function_64eaa790(var_4cfa0710, var_8343acf6, radius);
}

function goto(var_4cfa0710, position, var_690561dc, show_splash, show_waypoint, var_c3056ba3 = # "hash_7057d3992f70bf08") {
  if(isDefined(mission.var_c68f10d0[var_4cfa0710])) {
    update_position(var_4cfa0710, position);
    return;
  }

  set(var_c3056ba3, position, 0, var_4cfa0710, var_690561dc, show_splash, show_waypoint);
}

function function_4eb5c04a(var_4cfa0710, position, var_690561dc, show_splash, show_waypoint, var_c3056ba3 = # "hash_6d05b1cec06f98c") {
  goto(var_4cfa0710, position, var_690561dc, show_splash, show_waypoint, var_c3056ba3);
}

function scripted(var_4cfa0710, a_ents, var_690561dc, show_splash, var_bfcac307) {
  set(#"cp_scripted", a_ents, 1, var_4cfa0710, var_690561dc, show_splash, 0, var_bfcac307);
}

function convert(var_4cfa0710, var_c3056ba3) {
  if(isDefined(mission.var_c68f10d0[var_4cfa0710])) {
    objective_add(mission.var_c68f10d0[var_4cfa0710], "active", (0, 0, 0), var_c3056ba3);
  }
}

function remove(str_objective, a_targets) {
  if(isDefined(a_targets)) {
    if(!isDefined(a_targets)) {
      a_targets = [];
    } else if(!isarray(a_targets)) {
      a_targets = array(a_targets);
    }

    foreach(target in a_targets) {
      if(target function_31679256(str_objective)) {
        n_obj_id = target.a_n_objective_ids[str_objective];
        target.a_n_objective_ids[str_objective] = undefined;
        objectives_ui::remove_objective(n_obj_id);
        objective_delete(n_obj_id);
        gameobjects::release_obj_id(n_obj_id);
      }
    }

    return;
  }

  if(isDefined(mission.var_c68f10d0[str_objective])) {
    n_obj_id = mission.var_c68f10d0[str_objective];
    mission.var_c68f10d0[str_objective] = undefined;
    objectives_ui::remove_objective(n_obj_id);
    objective_delete(n_obj_id);
    gameobjects::release_obj_id(n_obj_id);
  }
}

function update_position(str_objective, position) {
  if(isDefined(mission.var_c68f10d0[str_objective])) {
    if(isentity(position)) {
      objective_onentity(mission.var_c68f10d0[str_objective], position);
    } else {
      objective_clearentity(mission.var_c68f10d0[str_objective]);
      objective_setposition(mission.var_c68f10d0[str_objective], position);
    }

    if(objective_state(mission.var_c68f10d0[str_objective]) == "done") {
      objective_setstate(mission.var_c68f10d0[str_objective], "active");
      objectives_ui::set_state(mission.var_c68f10d0[str_objective], 0);
      thread objectives_ui::function_f4a32e0b(str_objective, undefined, 1);
    }

    thread objectives_ui::function_6b177efc(str_objective);
  }
}

function function_64eaa790(str_objective, var_8343acf6, radius, var_4003470b = 1) {
  target = undefined;

  if(self !== level) {
    target = self;
  }

  objid = function_285e460(str_objective, target);

  if(isDefined(objid)) {
    if(isentity(var_8343acf6)) {
      if(!isDefined(radius)) {
        thread function_b6b76073(str_objective, var_8343acf6, var_4003470b);
      } else {
        thread function_634c16ef(str_objective, var_8343acf6, radius, var_4003470b);
      }

      return;
    }

    if(isDefined(radius)) {
      thread function_37cf9b17(str_objective, var_8343acf6, radius, var_4003470b);
      return;
    }

    assertmsg("<dev string:x38>");
  }
}

function complete(str_objective, a_targets, var_834e72f6 = 0) {
  if(isDefined(a_targets)) {
    if(!isDefined(a_targets)) {
      a_targets = [];
    } else if(!isarray(a_targets)) {
      a_targets = array(a_targets);
    }

    foreach(target in a_targets) {
      if(target function_31679256(str_objective)) {
        function_45951a55(str_objective);
        n_obj_id = target.a_n_objective_ids[str_objective];
        objective_setstate(n_obj_id, "done");

        if(objectives_ui::function_1fe5876a(n_obj_id)) {
          objectives_ui::set_state(n_obj_id, 1);

          if(var_834e72f6) {
            objectives_ui::function_79ed6d2(1);
          }
        } else {
          gameobjects::release_obj_id(n_obj_id);
          target.a_n_objective_ids[str_objective] = undefined;

          if(var_834e72f6 && isDefined(mission.var_c68f10d0[str_objective]) && objectives_ui::function_1fe5876a(mission.var_c68f10d0[str_objective])) {
            objectives_ui::function_79ed6d2(1);
          }
        }

        target notify("complete_objective_" + str_objective);
      }
    }

    return;
  }

  if(isDefined(mission.var_c68f10d0[str_objective])) {
    n_obj_id = mission.var_c68f10d0[str_objective];
    objective_setstate(n_obj_id, "done");

    if(objectives_ui::function_1fe5876a(n_obj_id)) {
      objectives_ui::set_state(n_obj_id, 1);

      if(var_834e72f6) {
        objectives_ui::function_79ed6d2(var_834e72f6);
      }

      return;
    }

    gameobjects::release_obj_id(n_obj_id);
    mission.var_c68f10d0[str_objective] = undefined;
  }
}

function function_aa8c2bb2(str_objective, a_targets) {
  self endon(#"deleted", "complete_objective_" + a_targets);
  self waittill(#"death", #"remove_objective");
  thread complete(a_targets, self);
}

function show(str_objective, a_targets, e_player) {
  a_n_objective_ids = function_d849bbf2(str_objective, a_targets);

  foreach(n_objective_id in a_n_objective_ids) {
    if(isDefined(e_player)) {
      objective_setvisibletoplayer(n_objective_id, e_player);
      continue;
    }

    objective_setvisibletoall(n_objective_id);
  }
}

function hide(str_objective, a_targets, e_player) {
  a_n_objective_ids = function_d849bbf2(str_objective, a_targets);

  foreach(n_objective_id in a_n_objective_ids) {
    if(isDefined(e_player)) {
      objective_setinvisibletoplayer(n_objective_id, e_player);
      continue;
    }

    objective_setinvisibletoall(n_objective_id);
  }
}

function function_9dfb43fc() {
  globallogic_ui::function_9ed5232e("hudItems.hideWaypoints", 1);
}

function function_4279fd02() {
  globallogic_ui::function_9ed5232e("hudItems.hideWaypoints", 0);
}

function set_progress(str_objective, a_targets, n_progress) {
  a_n_objective_ids = function_d849bbf2(str_objective, a_targets);

  foreach(n_objective_id in a_n_objective_ids) {
    objective_setprogress(n_objective_id, n_progress);
    objectives_ui::set_progress(n_objective_id, n_progress);
  }
}

function function_630d2576(str_objective, a_targets, var_4f8b76db) {
  a_n_objective_ids = function_d849bbf2(str_objective, a_targets);

  foreach(n_objective_id in a_n_objective_ids) {
    objective_setgamemodeflags(n_objective_id, var_4f8b76db);
  }
}

function function_1de88d60(str_objective, a_targets, var_177f646b, var_d126f60d) {
  a_n_objective_ids = function_d849bbf2(str_objective, a_targets);

  foreach(n_objective_id in a_n_objective_ids) {
    if(isDefined(var_177f646b)) {
      objective_setuimodelvalue(n_objective_id, "obj_x", var_177f646b);
      objectives_ui::function_97d05398(n_objective_id, var_177f646b);
    }

    if(isDefined(var_d126f60d)) {
      objective_setuimodelvalue(n_objective_id, "obj_y", var_d126f60d);
      objectives_ui::function_302128de(n_objective_id, var_d126f60d);
    }
  }

  if(isDefined(mission.var_c68f10d0[str_objective])) {
    mission.var_ac8e2ff9[str_objective] = var_177f646b;
  }
}

function function_45951a55(str_objective) {
  if(isDefined(mission.var_c68f10d0[str_objective]) && isDefined(mission.var_ac8e2ff9[str_objective])) {
    mission.var_ac8e2ff9[str_objective]++;
    objective_id = mission.var_c68f10d0[str_objective];
    objective_setuimodelvalue(objective_id, "obj_x", mission.var_ac8e2ff9[str_objective]);
    objectives_ui::function_97d05398(objective_id, mission.var_ac8e2ff9[str_objective]);
  }
}

function function_3595a59d(str_objective) {
  if(isDefined(mission.var_c68f10d0[str_objective]) && isDefined(mission.var_ac8e2ff9[str_objective])) {
    mission.var_ac8e2ff9[str_objective]--;
    objective_id = mission.var_c68f10d0[str_objective];
    objective_setuimodelvalue(objective_id, "obj_x", mission.var_ac8e2ff9[str_objective]);
    objectives_ui::function_97d05398(objective_id, mission.var_ac8e2ff9[str_objective]);
  }
}

function set_value(str_objective, a_targets, var_9922f839, n_value) {
  a_n_objective_ids = function_d849bbf2(str_objective, a_targets);

  foreach(n_objective_id in a_n_objective_ids) {
    objective_setuimodelvalue(n_objective_id, var_9922f839, n_value);
    objectives_ui::function_302128de(n_objective_id, n_value);
  }
}

function function_6a43edf3(str_objective, a_targets) {
  a_n_objective_ids = function_d849bbf2(str_objective, a_targets);

  foreach(n_objective_id in a_n_objective_ids) {
    objectives_ui::function_6a43edf3(n_objective_id);
  }
}

function function_572778b9(str_objective) {
  obj_id = function_285e460(str_objective);

  if(isDefined(obj_id)) {
    objectives_ui::function_572778b9(obj_id);
  }
}

function function_6a5ca7ac(str_objective, a_target, var_f4089be9, var_52710aa4, var_834e72f6 = 1) {
  parent_id = function_285e460(var_f4089be9, var_52710aa4);

  if(isDefined(parent_id)) {
    a_n_objective_ids = function_d849bbf2(str_objective, a_target);

    foreach(n_objective_id in a_n_objective_ids) {
      objectives_ui::function_6a5ca7ac(n_objective_id, parent_id, var_834e72f6);
    }
  }
}

function function_5d6a7294(str_objective, a_targets) {
  a_n_objective_ids = function_d849bbf2(str_objective, a_targets);

  foreach(n_objective_id in a_n_objective_ids) {
    objectives_ui::function_6a5ca7ac(n_objective_id, -1);
  }
}

function set_state(str_objective, a_targets, str_state) {
  a_n_objective_ids = function_d849bbf2(str_objective, a_targets);

  foreach(n_objective_id in a_n_objective_ids) {
    objective_setstate(n_objective_id, str_state);
  }
}

function function_67f87f80(str_objective, a_targets, text) {
  if(isDefined(a_targets)) {
    if(!isDefined(a_targets)) {
      a_targets = [];
    } else if(!isarray(a_targets)) {
      a_targets = array(a_targets);
    }

    foreach(target in a_targets) {
      thread objectives_ui::function_49dec5b(str_objective, target, text);
    }

    return;
  }

  thread objectives_ui::function_49dec5b(str_objective, undefined, text);
}

function function_fb65245c(str_objective, a_targets, icon) {
  if(isDefined(a_targets)) {
    if(!isDefined(a_targets)) {
      a_targets = [];
    } else if(!isarray(a_targets)) {
      a_targets = array(a_targets);
    }

    foreach(target in a_targets) {
      thread objectives_ui::function_fdeb5e85(str_objective, target, icon);
    }

    return;
  }

  thread objectives_ui::function_fdeb5e85(str_objective, undefined, icon);
}

function function_509db762(str_objective, a_targets, var_bc9bff3f, ...) {
  a_n_objective_ids = function_d849bbf2(str_objective, a_targets);

  foreach(n_objective_id in a_n_objective_ids) {
    a_args = arraycombine(array(n_objective_id), vararg, 1, 0);
    util::single_func_argarray(undefined, var_bc9bff3f, a_args);
  }
}

function function_285e460(str_objective, target, var_be4d91fa = 0) {
  if(isDefined(target)) {
    if(target function_31679256(str_objective)) {
      return target.a_n_objective_ids[str_objective];
    }
  }

  var_be4d91fa = var_be4d91fa || !isDefined(target);

  if(var_be4d91fa && isDefined(mission.var_c68f10d0[str_objective])) {
    return mission.var_c68f10d0[str_objective];
  }

  return undefined;
}

function function_d849bbf2(str_objective, a_targets) {
  a_n_objective_ids = [];

  if(isDefined(a_targets)) {
    if(!isDefined(a_targets)) {
      a_targets = [];
    } else if(!isarray(a_targets)) {
      a_targets = array(a_targets);
    }

    foreach(target in a_targets) {
      if(isDefined(target) && !function_3132f113(target) && target function_31679256(str_objective)) {
        if(!isDefined(a_n_objective_ids)) {
          a_n_objective_ids = [];
        } else if(!isarray(a_n_objective_ids)) {
          a_n_objective_ids = array(a_n_objective_ids);
        }

        a_n_objective_ids[a_n_objective_ids.size] = target.a_n_objective_ids[str_objective];
      }
    }
  } else if(isDefined(mission.var_c68f10d0[str_objective])) {
    if(!isDefined(a_n_objective_ids)) {
      a_n_objective_ids = [];
    } else if(!isarray(a_n_objective_ids)) {
      a_n_objective_ids = array(a_n_objective_ids);
    }

    a_n_objective_ids[a_n_objective_ids.size] = mission.var_c68f10d0[str_objective];
  }

  return a_n_objective_ids;
}

function private function_31679256(str_objective) {
  return isDefined(self.a_n_objective_ids) && isDefined(self.a_n_objective_ids[str_objective]);
}

function private function_5f2c6084(var_75de6891, str_objective, var_4003470b) {
  target = undefined;

  if(self !== level) {
    target = self;
  }

  if(var_75de6891) {
    hide(str_objective, target);
  } else if(isDefined(str_objective)) {
    show(str_objective, target);
  }

  if(var_4003470b) {
    if(var_75de6891) {
      objectives_ui::function_b6d41b41(#"hash_55ff57573b3951ef", 1);
      return;
    }

    objectives_ui::function_be5b472b();
  }
}

function private function_b6b76073(str_objective, ent, var_4003470b) {
  level notify("objective_search_area_" + str_objective);

  if(var_4003470b) {
    level endoncallback(&function_d5874fcc, "objective_search_area_" + str_objective);
  }

  target = undefined;

  if(self !== level) {
    target = self;

    if(isentity(target)) {
      target endon(#"death");
    }
  }

  objid = function_285e460(str_objective, target);
  player = getplayers()[0];
  player endon(#"death");
  in_area = 0;

  while(isDefined(objid) && objective_state(objid) == "active") {
    if(!in_area && player istouching(ent) || in_area && !player istouching(ent)) {
      in_area = !in_area;
      function_5f2c6084(in_area, str_objective, var_4003470b);
    }

    waitframe(1);
  }

  if(var_4003470b) {
    function_d5874fcc();
  }
}

function private function_634c16ef(str_objective, ent, radius, var_4003470b) {
  level notify("objective_search_area_" + str_objective);

  if(var_4003470b) {
    level endoncallback(&function_d5874fcc, "objective_search_area_" + str_objective);
  }

  target = undefined;

  if(self !== level) {
    target = self;

    if(isentity(target)) {
      target endon(#"death");
    }
  }

  objid = function_285e460(str_objective, target);
  player = getplayers()[0];
  player endon(#"death");

  if(isentity(ent)) {
    ent endon(#"death");
  }

  radius_squared = radius * radius;
  in_area = 0;

  while(isDefined(objid) && objective_state(objid) == "active") {
    if(!in_area && distancesquared(player.origin, ent.origin) <= radius_squared || in_area && distancesquared(player.origin, ent.origin) > radius_squared) {
      in_area = !in_area;
      function_5f2c6084(in_area, str_objective, var_4003470b);
    }

    waitframe(1);
  }

  if(var_4003470b) {
    function_d5874fcc();
  }
}

function private function_37cf9b17(str_objective, pos, radius, var_4003470b) {
  level notify("objective_search_area_" + str_objective);

  if(var_4003470b) {
    level endoncallback(&function_d5874fcc, "objective_search_area_" + str_objective);
  }

  target = undefined;

  if(self !== level) {
    target = self;

    if(isentity(target)) {
      target endon(#"death");
    }
  }

  objid = function_285e460(str_objective, target);
  player = getplayers()[0];
  player endon(#"death");
  radius_squared = radius * radius;
  in_area = 0;

  while(isDefined(objid) && objective_state(objid) == "active") {
    if(!in_area && distancesquared(player.origin, pos) <= radius_squared || in_area && distancesquared(player.origin, pos) > radius_squared) {
      in_area = !in_area;
      function_5f2c6084(in_area, str_objective, var_4003470b);
    }

    waitframe(1);
  }

  if(var_4003470b) {
    function_d5874fcc();
  }
}

function private function_d5874fcc(var_201c5b1f) {
  objectives_ui::function_be5b472b();
}