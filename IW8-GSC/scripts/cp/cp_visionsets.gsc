/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_visionsets.gsc
***********************************************/

function vision_set_management() {
  var0 = undefined;
  var1 = undefined;

  for(;;) {
    level waittill("vision_set_change_request", var0, var1, var2, var3);

    if(!isDefined(var0) && isDefined(var3)) {
      if(!isstring(var3)) {
        continue;
      }

      if(var3 == "") {
        continue;
      }

      if(isDefined(var1)) {
        if(!isPlayer(var1)) {
          continue;
        }

        remove_visionset_specific_from_stack(var1, var3, var2);
      } else {
        foreach(var5 in level.players) {
          remove_visionset_specific_from_stack(var5, var3, var2);
        }
      }

      continue;
    }

    if(!isDefined(var0) || !isstring(var0)) {
      continue;
    }

    if(isDefined(var1)) {
      if(!isPlayer(var1)) {
        continue;
      }

      if(var0 == "") {
        remove_visionset_from_stack(var1, var2);
      } else {
        add_visionset_to_stack(var1, var0, var2);
      }

      continue;
    }

    foreach(var5 in level.players) {
      if(var0 == "") {
        remove_visionset_from_stack(var5, var2);
        continue;
      }

      add_visionset_to_stack(var5, var0, var2);
    }
  }
}

function create_visionset_stack(var0) {
  var0.visionset_stack = [""];
  var0.visionset_pointer = var0.visionset_stack.size - 1;
  var0.current_visionset = var0.visionset_stack[var0.visionset_pointer];
  var0 visionsetnakedforplayer(var0.current_visionset);
}

function add_visionset_to_stack(var0, var1, var2) {
  var0.old_visionset = var0.visionset_stack[var0.visionset_pointer];
  var0.visionset_stack = scripts\engine\utility::array_add(var0.visionset_stack, var1);
  var0.visionset_pointer = var0.visionset_stack.size - 1;
  var0.current_visionset = var0.visionset_stack[var0.visionset_pointer];

  if(isDefined(var2)) {
    var0 visionsetnakedforplayer(var0.current_visionset, var2);
    return;
  }

  var0 visionsetnakedforplayer(var0.current_visionset);
}

function remove_visionset_from_stack(var0, var1) {
  if(var0.visionset_pointer <= 0) {} else {
    var0.old_visionset = var0.visionset_stack[var0.visionset_pointer];
    var0.visionset_stack = scripts\engine\utility::array_remove_index(var0.visionset_stack, var0.visionset_pointer);
    var0.visionset_pointer--;
    var0.current_visionset = var0.visionset_stack[var0.visionset_pointer];
  }

  if(isDefined(var1)) {
    var0 visionsetnakedforplayer(var0.current_visionset, var1);
    return;
  }

  var0 visionsetnakedforplayer(var0.current_visionset);
}

function remove_visionset_specific_from_stack(var0, var1, var2) {
  if(var0.visionset_pointer > 0) {
    var0.visionset_stack = scripts\engine\utility::array_remove(var0.visionset_stack, var1);
    var0.visionset_pointer--;
    var0.current_visionset = var0.visionset_stack[var0.visionset_pointer];
  }

  if(isDefined(var0.current_visionset)) {
    if(isDefined(var2)) {
      var0 visionsetnakedforplayer(var0.current_visionset, var2);
      return;
    }

    var0 visionsetnakedforplayer(var0.current_visionset);
    return;
  }
}