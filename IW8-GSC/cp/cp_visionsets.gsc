/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_visionsets.gsc
***********************************************/

vision_set_management() {
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    level waittill("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", var_0, var_1, var_2, var_3);

    if(!isDefined(var_0) && isDefined(var_3)) {
      if(!isstring(var_3)) {
        continue;
      }
      if(var_3 == "_encstr_B40101") {
        continue;
      }
      if(isDefined(var_1)) {
        if(!isPlayer(var_1)) {
          continue;
        }
        remove_visionset_specific_from_stack(var_1, var_3, var_2);
      } else {
        foreach(var_5 in level.players)
        remove_visionset_specific_from_stack(var_5, var_3, var_2);
      }

      continue;
    }

    if(!isDefined(var_0) || !isstring(var_0)) {
      continue;
    }
    if(isDefined(var_1)) {
      if(!isPlayer(var_1)) {
        continue;
      }
      if(var_0 == "_encstr_B40101")
        remove_visionset_from_stack(var_1, var_2);
      else
        add_visionset_to_stack(var_1, var_0, var_2);

      continue;
    }

    foreach(var_5 in level.players) {
      if(var_0 == "_encstr_B40101") {
        remove_visionset_from_stack(var_5, var_2);
        continue;
      }

      add_visionset_to_stack(var_5, var_0, var_2);
    }
  }
}

create_visionset_stack(var_0) {
  var_0.visionset_stack = ["_encstr_B40101"];
  var_0.visionset_pointer = var_0.visionset_stack.size - 1;
  var_0.current_visionset = var_0.visionset_stack[var_0.visionset_pointer];
  var_0 visionsetnakedforplayer(var_0.current_visionset);
}

add_visionset_to_stack(var_0, var_1, var_2) {
  var_0.old_visionset = var_0.visionset_stack[var_0.visionset_pointer];
  var_0.visionset_stack = scripts\engine\utility::array_add(var_0.visionset_stack, var_1);
  var_0.visionset_pointer = var_0.visionset_stack.size - 1;
  var_0.current_visionset = var_0.visionset_stack[var_0.visionset_pointer];

  if(isDefined(var_2))
    var_0 visionsetnakedforplayer(var_0.current_visionset, var_2);
  else
    var_0 visionsetnakedforplayer(var_0.current_visionset);
}

remove_visionset_from_stack(var_0, var_1) {
  if(var_0.visionset_pointer <= 0) {} else {
    var_0.old_visionset = var_0.visionset_stack[var_0.visionset_pointer];
    var_0.visionset_stack = scripts\engine\utility::array_remove_index(var_0.visionset_stack, var_0.visionset_pointer);
    var_0.visionset_pointer--;
    var_0.current_visionset = var_0.visionset_stack[var_0.visionset_pointer];
  }

  if(isDefined(var_1))
    var_0 visionsetnakedforplayer(var_0.current_visionset, var_1);
  else
    var_0 visionsetnakedforplayer(var_0.current_visionset);
}

remove_visionset_specific_from_stack(var_0, var_1, var_2) {
  if(var_0.visionset_pointer > 0) {
    var_0.visionset_stack = scripts\engine\utility::array_remove(var_0.visionset_stack, var_1);
    var_0.visionset_pointer--;
    var_0.current_visionset = var_0.visionset_stack[var_0.visionset_pointer];
  }

  if(isDefined(var_0.current_visionset)) {
    if(isDefined(var_2))
      var_0 visionsetnakedforplayer(var_0.current_visionset, var_2);
    else
      var_0 visionsetnakedforplayer(var_0.current_visionset);
  }
}