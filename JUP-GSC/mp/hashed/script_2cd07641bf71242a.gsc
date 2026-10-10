/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2cd07641bf71242a.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\traverse;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_4fecf90fd9e5c41a;

function function_64d97cf652a4d385() {
  self.var_acb02d417fdecc8f = &function_4fcd5f899c149076;
  self.var_bb9dc4a1372891c6 = &function_46b64b8f6d835b78;
}

function teleporttraverse(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");
  startnode = undefined;

  if(self.var_32a34987ee1b3095 == "node_based") {
    startnode = self getnegotiationstartnode();
    startnode = default_to(startnode, self.traversal_start_node);
    assert(isDefined(startnode));
  }

  startpos = undefined;
  endpos = undefined;

  if(self.var_32a34987ee1b3095 == "nodeless" || self.var_32a34987ee1b3095 == "linkless") {
    if(self.var_32a34987ee1b3095 == "linkless" && self.var_59c43504d7aabb7a == "fence") {
      var_e8885693728fd806 = &function_3bb347b40346528a;
    } else if(isDefined(self.var_bb9dc4a1372891c6)) {
      var_e8885693728fd806 = self.var_bb9dc4a1372891c6;
    }

    assertex(isDefined(var_e8885693728fd806), "<dev string:x1c>");
    self.var_64b933af90edc53c = self[[var_e8885693728fd806]]();
    startpos = self.var_64b933af90edc53c.origin;
    endpos = self.var_64b933af90edc53c.endpos;
  } else if(self.var_32a34987ee1b3095 == "node_based") {
    startpos = startnode.origin;
    endpos = self getnegotiationendpos();

    if(!isDefined(endpos)) {
      endnode = self getnegotiationendnode();

      if(!isDefined(endnode) && isDefined(self.traversal_end_node)) {
        endpos = self.traversal_end_node.origin;
      }
    }
  }

  if(isDefined(endpos)) {
    self forceteleport(endpos, self.angles);

    animscript = "<dev string:x6d>";
    data_calculated = "<dev string:x6d>";

    if(isDefined(startnode) && isDefined(startnode.animscript)) {
      animscript = "<dev string:x71>" + startnode.animscript + "<dev string:x81>";
      data_calculated = "<dev string:x88>" + ter_op(istrue(startnode.var_e25867ac07f6cb19), "<dev string:x98>", "<dev string:xa0>");
    }

    println("<dev string:xa9>" + startpos + "<dev string:x81>" + animscript + data_calculated);
    record3dtext("<dev string:xfe>" + animscript + data_calculated, self.origin + (0, 0, 70), (1, 0, 1));
  }

  terminatetraverse(asmname, statename);
}

function function_46b64b8f6d835b78() {
  var_73ba1b0a68c224f5 = self.var_c97cd7821467b22c;
  var_ef78260982b9116c = self.var_e341ef38b14d5cd3;
  warp_params = spawnStruct();
  warp_params.angles = vectortoangles(flat_origin(var_ef78260982b9116c - var_73ba1b0a68c224f5));
  warp_params.origin = var_73ba1b0a68c224f5;
  warp_params.endpos = var_ef78260982b9116c;

  if(abs(var_73ba1b0a68c224f5[2] - var_ef78260982b9116c[2]) < 5) {
    apex_point = averagepoint([var_73ba1b0a68c224f5, var_ef78260982b9116c]);
  } else {
    apex_point = function_fda6a76c32365675(var_73ba1b0a68c224f5, var_ef78260982b9116c);

    if(!isDefined(apex_point)) {
      apex_point = averagepoint([var_73ba1b0a68c224f5, var_ef78260982b9116c]);
    }
  }

  if(isDefined(apex_point)) {
    warp_params.var_e25867ac07f6cb19 = 1;
    warp_params.traverse_height = apex_point[2];
    warp_params.traverse_height_delta = apex_point[2] - var_73ba1b0a68c224f5[2];
    warp_params.traverse_drop_height_delta = apex_point[2] - var_ef78260982b9116c[2];
    warp_params.apex_delta = apex_point - var_73ba1b0a68c224f5;

    if(isDefined(self.var_371c13977bb78c59)) {
      warp_params.traversetype = [[self.var_371c13977bb78c59]](undefined, warp_params);
    }
  }

  if(isDefined(warp_params.traversetype) && warp_params.traversetype == "traverse_warp_across") {
    warp_params.across_delta = var_ef78260982b9116c - var_73ba1b0a68c224f5;
  }

  return warp_params;
}

function function_c4b3846ecfe9e4ec(asmname, statename, params) {
  self.var_371c13977bb78c59 = default_to(self.var_371c13977bb78c59, &function_486011c6564f32e5);
  self.var_12a6a7d538790f6e = default_to(self.var_12a6a7d538790f6e, &function_27277e151d315a62);

  if(self.var_32a34987ee1b3095 == "<dev string:x121>") {
    assertex(isDefined(self.var_c97cd7821467b22c), "<dev string:x12d>" + self.origin);
  }

  scripts\asm\traverse::calctraversetype(asmname, statename, params);
}

function private function_486011c6564f32e5(currenttype, traverse_params) {
  if(function_8f0f50119c5937bb(currenttype)) {
    return currenttype;
  }

  if(isDefined(self.var_ad4d9f5a34656396)) {
    if(self.var_ad4d9f5a34656396 == "traverse_wall") {
      return "traverse_wall";
    } else if(self.var_ad4d9f5a34656396 == "traverse_ground") {
      return "traverse_ground";
    }
  }

  var_f137529d107e68cb = 108;
  across_height = 100;
  var_5234b8c29e944631 = 20;
  height_delta = 0;
  drop_height_delta = 0;
  across_dist = undefined;

  if(isDefined(traverse_params)) {
    assert(traverse_params.var_e25867ac07f6cb19);
    height_delta = traverse_params.traverse_height_delta;
    drop_height_delta = traverse_params.traverse_drop_height_delta;

    if(isDefined(traverse_params.across_delta)) {
      across_dist = length2d(traverse_params.across_delta);
    } else if(!isDefined(currenttype) || currenttype == "traverse_warp_across" || !isDefined(traverse_params.traversetype) || traverse_params.traversetype == "traverse_warp_across") {
      across_dist = length2d(traverse_params.endpos - traverse_params.origin);
    }
  } else {
    startpos = self function_ad3c975cb94e4736();

    if(!isDefined(startpos)) {
      startnode = self.traversal_start_node;

      if(isDefined(startnode)) {
        startpos = startnode.origin;
      } else {
        startpos = self.origin;
      }
    }

    endpos = self getnegotiationendpos();

    if(!isDefined(endpos)) {
      if(isDefined(self.traversal_end_node)) {
        endpos = self.traversal_end_node.origin;
      } else {
        assertmsg("<dev string:x164>" + startpos);
        return undefined;
      }
    }

    if(abs(startpos[2] - endpos[2]) < 5) {
      apexpoint = averagepoint([startpos, endpos]);
    } else {
      apexpoint = function_fda6a76c32365675(startpos, endpos);

      if(!isDefined(apexpoint)) {
        assertmsg("<dev string:x1a0>" + startpos + "<dev string:x1de>" + endpos);
        return undefined;
      }
    }

    height_delta = apexpoint[2] - startpos[2];
    drop_height_delta = apexpoint[2] - endpos[2];

    if(!isDefined(startnode) || !isDefined(startnode.animscript) || startnode.animscript == "traverse_warp_across") {
      across_dist = length2d(endpos - startpos);
    }
  }

  if(isDefined(across_dist) && across_dist > var_f137529d107e68cb && height_delta < across_height && drop_height_delta < across_height) {
    return "traverse_warp_across";
  }

  if(height_delta > var_5234b8c29e944631 && drop_height_delta > var_5234b8c29e944631) {
    return "traverse_warp_over";
  } else if(height_delta < var_5234b8c29e944631 && drop_height_delta < var_5234b8c29e944631) {
    return "traverse_warp_across";
  } else if(drop_height_delta < height_delta) {
    return "traverse_warp_up";
  } else if(drop_height_delta >= height_delta) {
    return "traverse_warp_down";
  }

  return undefined;
}

function private function_27277e151d315a62(featurearray, type) {
  if(self.var_32a34987ee1b3095 == "nodeless" || self.var_32a34987ee1b3095 == "linkless") {
    assertex(isDefined(self.var_64b933af90edc53c) && self.var_64b933af90edc53c.var_e25867ac07f6cb19, "<dev string:x1ed>");
  } else if(self.var_32a34987ee1b3095 == "node_based") {
    assertex(isDefined(self.traversal_start_node) && isDefined(self.traversal_start_node.traverse_height), "<dev string:x230>");

    if(isDefined(self.traversal_start_node)) {
      end_node = self.traversal_end_node;

      if(isDefined(end_node)) {
        if(type == "traverse_warp_up" || issubstr(type, "climb_building_up")) {
          featurearray["drop_height"] = 0;
          featurearray["height"] = end_node.origin[2] - self.traversal_start_node.origin[2];
        } else if(type == "traverse_warp_down" || issubstr(type, "climb_building_down")) {
          featurearray["drop_height"] = self.traversal_start_node.origin[2] - end_node.origin[2];
          featurearray["height"] = 0;
        } else if(type == "traverse_warp_across") {
          featurearray["length"] = distance2d(self.traversal_start_node.origin, end_node.origin);
        }
      }
    }
  }

  featurearray["climb_building_type"] = "";

  if(issubstr(type, "climb_building_up")) {
    tokens = strtok(type, "_");

    if(isDefined(tokens[3]) && tokens[3] != "") {
      featurearray["climb_building_type"] = tokens[3];
    }
  }

  if(isDefined(self.var_db44b0ed0f52e2b)) {
    featurearray = array_combine_unique_keys(self.var_db44b0ed0f52e2b, featurearray);
  }

  return featurearray;
}

function private function_8f0f50119c5937bb(type) {
  if(!isDefined(type)) {
    return false;
  }

  switch (type) {
    case #"hash_20e18a3582122c1f":
    case #"hash_2517ba3af2f13858":
    case #"hash_3929e05b5be2d50d":
    case #"hash_668adb9645eda622":
    case #"hash_9e0d753b4c4375e3":
    case #"hash_e8ee1dc75e1bef22":
      return true;
  }

  if(issubstr(type, "climb_building_up") || issubstr(type, "climb_building_down")) {
    if(self asmhasstate(self.asmname, type)) {
      return true;
    }
  }

  if(self asmhasstate(self.asmname, "traverse_custom") && asm_lookupanimfromaliasifexists("traverse_custom", type) != undefined) {
    return true;
  }

  return false;
}

function private function_4fcd5f899c149076(note) {
  if(note == "warp_arrival_start") {
    if(self.var_32a34987ee1b3095 == "nodeless" || self.var_32a34987ee1b3095 == "linkless") {
      if(!isDefined(self.var_64b933af90edc53c)) {
        println("<dev string:x26e>" + self.var_32a34987ee1b3095 + "<dev string:x2ab>");
        return;
      }

      targetangles = self.var_64b933af90edc53c.angles;
    } else {
      if(!isDefined(self.traversestartnode)) {
        println("<dev string:x2dd>" + self.var_32a34987ee1b3095 + "<dev string:x314>");
        return;
      }

      targetangles = self.traversestartnode.angles;
    }

    if(isDefined(targetangles)) {
      yaw_diff = absangleclamp180(targetangles[1] - self.angles[1]);
      var_9e4cfe0d44c34dfe = 45;

      if(yaw_diff > var_9e4cfe0d44c34dfe) {
        thread rotatetotraversal(targetangles[1]);

        print3d(self.origin + (10, 0, 0), "<dev string:x345>" + yaw_diff, (1, 1, 0.9), 0.8, 0.5);
      }
    }
  }
}

function private rotatetotraversal(target_yaw) {
  var_690fb7cd50d952c3 = 200;
  self endon("death");
  yaw = self.angles[1];

  while(yaw != target_yaw && istrue(self.var_20a0e88052918576)) {
    yaw = self.angles[1];
    rotation_speed = level.framedurationseconds * var_690fb7cd50d952c3;
    diff = angleclamp180(target_yaw - yaw);
    new_yaw = undefined;

    if(abs(diff) < rotation_speed) {
      new_yaw = target_yaw;
    } else {
      new_yaw = yaw + scripts\engine\utility::sign(diff) * rotation_speed;
    }

    new_angles = (self.angles[0], new_yaw, self.angles[2]);
    self forceteleport(self.origin, new_angles);
    waitframe();
  }
}

function function_37ec13c91574883c(asmname, statename, params) {
  startnode = function_234a86bad9f7c8cf();
  endpos = self getnegotiationendpos();
  assertex(isDefined(startnode), "<dev string:x376>");
  assertex(isDefined(startnode.wall_nodes), "<dev string:x39b>");
  assertex(startnode.wall_nodes.size >= 2, "<dev string:x3bd>");
  animid = asm_getanim(asmname, statename);
  assertex(isDefined(animid), "<dev string:x3e1>");

  if(!isDefined(animid) || !isDefined(startnode) || !isDefined(startnode.wall_nodes) || startnode.wall_nodes.size < 2) {
    terminatetraverse(asmname, statename);
    return;
  }

  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, animid));
  self animmode("noclip");
  thread function_a8461d8c8de86efe(asmname, statename, startnode, endpos);
}

function function_a8461d8c8de86efe(asmname, statename, startnode, endpos) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");
  var_157e0150178595f2 = self.var_157e0150178595f2;
  self.var_157e0150178595f2 = 0;
  self.jumping = 1;

  if(startnode.wall_rolls.size > 0 && startnode.wall_rolls[0] != 0) {
    wallroll = startnode.wall_rolls[0];
  } else if(isDefined(startnode.var_143b20e77684b51) && istrue(startnode.var_143b20e77684b51)) {
    wallroll = 90;
  } else {
    wallroll = -90;
  }

  var_cb108454048737bb = vectortoangles(startnode.wall_nodes[1] - startnode.wall_nodes[0]);
  targetangles = (var_cb108454048737bb[0], var_cb108454048737bb[1], wallroll);
  self forceteleport(startnode.wall_nodes[0], targetangles, 10, 0, 1);
  assert(startnode.wall_nodes.size == startnode.wall_rolls.size);
  rndstart = randomfloat(1);
  pitchmultiplier = getdvarfloat(@ "hash_368b68b43590556d", 0);
  debugframes = getdvarint(@ "hash_507099c93f31940f", 0);
  lastpos = self.origin;

  for(i = 0; i < startnode.wall_nodes.size - 1; i++) {
    startposwall = startnode.wall_nodes[i];
    endposwall = startnode.wall_nodes[i + 1];
    var_5eb953348620e51f = endposwall - startposwall;

    if(pitchmultiplier > 0) {
      var_21279c66a0239416 = length(var_5eb953348620e51f);

      if(var_21279c66a0239416 == 0) {
        continue;
      }

      var_acd303f03e981a0c = var_5eb953348620e51f / var_21279c66a0239416;
    }

    if(debugframes > 0) {
      line(startposwall, endposwall, (1, 0, 0), 1, 0, debugframes);
    }

    var_b1b63ca2ea201b75 = vectortoangles(var_5eb953348620e51f);

    if(startnode.wall_rolls[i] != 0) {
      wallroll = startnode.wall_rolls[i];
    }

    targetangles = (var_b1b63ca2ea201b75[0], var_b1b63ca2ea201b75[1], wallroll);

    if(pitchmultiplier == 0) {
      self orientmode("face angle 3d", targetangles);
    }

    while(true) {
      if(pitchmultiplier > 0) {
        var_b9e885154e1e4fea = self.origin - startposwall;
        var_a40d3e2b5af48c06 = vectordot(var_b9e885154e1e4fea, var_acd303f03e981a0c);
        alphasegment = var_a40d3e2b5af48c06 / var_21279c66a0239416;
        pitchmod = sin((rndstart + alphasegment) * 360) * pitchmultiplier;
        targetangles = (var_b1b63ca2ea201b75[0] + pitchmod, var_b1b63ca2ea201b75[1], wallroll);
        self orientmode("face angle 3d", targetangles);
      }

      var_d644fdede50aa497 = endposwall - self.origin;

      if(vectordot(var_5eb953348620e51f, var_d644fdede50aa497) < 0) {
        break;
      }

      if(debugframes > 0) {
        line(lastpos, self.origin, (0, 1, 0), 1, 0, debugframes);
        lastpos = self.origin;
      }

      waitframe();
    }
  }

  self.var_157e0150178595f2 = var_157e0150178595f2;
  asm_fireevent(asmname, "end");
  self animmode("normal");
  self forceteleport(endpos, (self.angles[0], 0, 0));
  self.jumping = 0;
}

function private function_234a86bad9f7c8cf() {
  startnode = undefined;

  if(self.var_32a34987ee1b3095 == "not_set") {
    setupsuccess = self setuptraversaltransitioncheck(120);
    assert(setupsuccess);
  }

  if(self.var_32a34987ee1b3095 == "node_based") {
    startnode = self getnegotiationstartnode();

    if(!isDefined(startnode)) {
      self starttraversearrival(120);
      startnode = self getnegotiationstartnode();
    }

    assert(isDefined(startnode));
  } else if(self.var_32a34987ee1b3095 == "linkless" || self.var_32a34987ee1b3095 == "nodeless") {
    assertmsg("<dev string:x405>");
  } else {
    assertmsg("<dev string:x440>");
  }

  return startnode;
}

function function_4b209d7ba1366aa1(asmname, statename, params) {
  walk_nodes = function_ab33388488f8492b();
  animid = asm_getanim(asmname, statename);
  assertex(isDefined(animid), "<dev string:x464>");

  if(walk_nodes.size < 2 || !isDefined(animid)) {
    terminatetraverse(asmname, statename);
    return;
  }

  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, animid));
  self animmode("gravity_off_nav");
  thread function_3131bcdd32390c23(asmname, statename, walk_nodes);
}

function function_3131bcdd32390c23(asmname, statename, walk_nodes) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");
  var_157e0150178595f2 = self.var_157e0150178595f2;
  self.var_157e0150178595f2 = 0;

  for(i = 0; i < walk_nodes.size - 1; i++) {
    startpos = walk_nodes[i];
    endpos = walk_nodes[i + 1];
    var_93b71025e5032b3b = endpos - startpos;
    yaw = vectortoyaw(var_93b71025e5032b3b);
    self orientmode("face angle", yaw);

    while(true) {
      var_14899d470e0ce373 = endpos - self.origin;

      if(vectordot(var_93b71025e5032b3b, var_14899d470e0ce373) < 0) {
        break;
      }

      waitframe();
    }
  }

  self.var_157e0150178595f2 = var_157e0150178595f2;
  asm_fireevent(asmname, "end");
}

function private function_ab33388488f8492b() {
  walk_nodes = [];

  if(self.var_32a34987ee1b3095 == "not_set") {
    setupsuccess = self setuptraversaltransitioncheck(120);
    assert(setupsuccess);
  }

  if(self.var_32a34987ee1b3095 == "linkless") {
    startpos = self function_ad3c975cb94e4736();

    if(!isDefined(startpos)) {
      self starttraversearrival(120, self.var_e2b4fc394eef5c0f, self.var_64b933af90edc53c.origin, self.var_64b933af90edc53c.endpos);
      startpos = self function_ad3c975cb94e4736();
    }

    assert(isDefined(startpos));
    endpos = self getnegotiationendpos();
    walk_nodes = array_add(walk_nodes, startpos);
    walk_nodes = array_add(walk_nodes, endpos);
  } else if(self.var_32a34987ee1b3095 == "nodeless") {
    startpos = self function_ad3c975cb94e4736();

    if(!isDefined(startpos)) {
      self starttraversearrival(120, self.var_e2b4fc394eef5c0f);
      startpos = self function_ad3c975cb94e4736();
    }

    assert(isDefined(startpos));
    endpos = self getnegotiationendpos();
    walk_nodes = array_add(walk_nodes, startpos);
    walk_nodes = array_add(walk_nodes, endpos);
  } else if(self.var_32a34987ee1b3095 == "node_based") {
    startnode = self getnegotiationstartnode();

    if(!isDefined(startnode)) {
      self starttraversearrival(120);
      startnode = self getnegotiationstartnode();
    }

    assert(isDefined(startnode));
    walk_nodes = startnode.walk_nodes;
  } else {
    assertmsg("<dev string:x440>");
  }

  return walk_nodes;
}