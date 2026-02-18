/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_209c9c119ef6fc06.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_a9076ee3;
class class_d5e68311 {
  var var_21ab02f3;
  var var_2d9de19e;
  var var_2df3d617;
  var var_3d18872;
  var var_450307dc;
  var var_4fc15b0b;
  var var_76c10824;
  var var_884ed4f;
  var var_89c30c57;
  var var_b228f30;
  var var_e1c25a48;
  var var_e7fdf736;
  var var_e93e3086;
  var var_ec13f56d;
  var var_f141235b;
  var var_fef76413;

  constructor() {
    var_f141235b = 0;
    var_884ed4f = undefined;
    var_e93e3086 = (15, -3, 0);
    var_3d18872 = (0, 0, 0);
    var_2df3d617 = (0, 0, 0);
    var_21ab02f3 = (0, 0, 0);
    var_4fc15b0b = (15, -3, 0);
    var_2d9de19e = (0, 0, 0);
    var_450307dc = "";
    var_fef76413 = 0;
    var_76c10824 = 1;
    var_b228f30 = 0;
    var_89c30c57 = 0;
    var_ec13f56d = 1;
    var_e7fdf736 = 5;
    var_e1c25a48 = 0;
  }

  function function_7c6cd9d() {
    return var_f141235b;
  }

  function function_13f1dc62() {
    return {
      #enabled: var_ec13f56d, #max: var_e7fdf736
    };
  }

  function update_settings(var_4ce74bd9 = (15, -3, 0), var_40779d0d = (0, 0, 0), var_447b7d9b = 1, var_4c987939 = 1) {
    var_e93e3086 = var_4ce74bd9;
    var_3d18872 = var_40779d0d;
    var_76c10824 = var_447b7d9b;
    var_ec13f56d = var_4c987939;

    if(isDefined(var_884ed4f)) {
      function_f710ecd0();
      set_position(var_4fc15b0b, var_2d9de19e);
    }
  }

  function update_model(var_53008658 = "", is_hidden = 0) {
    var_38d97d58 = getscriptbundle(var_53008658);

    if(!isDefined(var_38d97d58)) {
      var_38d97d58 = {};
    }

    model_name = isDefined(var_38d97d58.uimodel) ? var_38d97d58.uimodel : "";
    var_4efbbcfe = isDefined(var_38d97d58.var_4efbbcfe) ? var_38d97d58.var_4efbbcfe : 0;
    var_4138e7ed = isDefined(var_38d97d58.var_4138e7ed) ? var_38d97d58.var_4138e7ed : 0;
    var_53be913a = isDefined(var_38d97d58.var_53be913a) ? var_38d97d58.var_53be913a : 5;
    positionoffset = (isDefined(var_38d97d58.xpositionoffset) ? var_38d97d58.xpositionoffset : 0, isDefined(var_38d97d58.ypositionoffset) ? var_38d97d58.ypositionoffset : 0, isDefined(var_38d97d58.zpositionoffset) ? var_38d97d58.zpositionoffset : 0);
    angleoffset = (isDefined(var_38d97d58.var_83f65202) ? var_38d97d58.var_83f65202 : 0, isDefined(var_38d97d58.var_b1e8fdfd) ? var_38d97d58.var_b1e8fdfd : 0, isDefined(var_38d97d58.var_ce8030c8) ? var_38d97d58.var_ce8030c8 : 0);

    if(var_450307dc == model_name) {
      return;
    }

    var_450307dc = model_name;
    var_b228f30 = var_4efbbcfe;
    var_89c30c57 = var_4138e7ed;
    var_e7fdf736 = var_53be913a;
    var_2df3d617 = positionoffset;
    var_21ab02f3 = angleoffset;
    var_e1c25a48 = is_hidden;
    function_f710ecd0();

    if(model_name != "") {
      if(!isDefined(var_884ed4f)) {
        var_884ed4f = util::spawn_model(var_f141235b, model_name, var_4fc15b0b, var_2d9de19e);
      } else {
        var_884ed4f setModel(model_name);
      }

      set_position(var_4fc15b0b, var_2d9de19e);
    } else if(isDefined(var_884ed4f) && function_75aa931a()) {
      var_884ed4f function_a052b638();
      var_fef76413 = 0;
      var_884ed4f delete();
    }

    if(isDefined(var_884ed4f)) {
      if(is_hidden) {
        var_884ed4f playrenderoverridebundle(#"hash_1d4878635b5ea5a3");
        return;
      }

      var_884ed4f stoprenderoverridebundle(#"hash_1d4878635b5ea5a3");
    }
  }

  function function_2e66587b(var_4c987939 = 1) {
    var_ec13f56d = var_4c987939;
  }

  function reset() {
    var_f141235b = 0;
    update_model();
    function_56293490();
    function_f710ecd0();
  }

  function function_56293490() {
    var_e93e3086 = (15, -3, 0);
    var_3d18872 = (0, 0, 0);
  }

  function is_hidden() {
    return is_true(var_e1c25a48);
  }

  function function_62571daf() {
    return var_3d18872 + var_21ab02f3;
  }

  function function_6e7ad37e() {
    return var_e93e3086 + var_2df3d617;
  }

  function function_75aa931a() {
    return is_true(var_fef76413);
  }

  function function_77f3574b(var_4ce74bd9 = (15, -3, 0)) {
    var_e93e3086 = var_4ce74bd9;
  }

  function set_client(local_client_num = 0) {
    assert(local_client_num >= 0 && local_client_num < getmaxlocalclients());
    var_f141235b = local_client_num;
  }

  function get_angle() {
    return var_2d9de19e;
  }

  function function_b4ecf5f4(local_client_num = 0, var_4ce74bd9, var_40779d0d, var_447b7d9b, var_4c987939) {
    var_f141235b = local_client_num;
    update_settings(var_4ce74bd9, var_40779d0d, var_447b7d9b, var_4c987939);
  }

  function set_position(origin, angle) {
    if(isDefined(origin)) {
      var_4fc15b0b = origin;
    }

    if(isDefined(angle)) {
      var_2d9de19e = angle;
    }

    if(isDefined(var_884ed4f)) {
      var_884ed4f function_a052b638();
      var_fef76413 = 0;
      var_884ed4f linktocamera(4, var_4fc15b0b, var_2d9de19e);
      var_fef76413 = 1;
    }
  }

  function function_d5f29651(var_40779d0d = (0, 0, 0)) {
    var_3d18872 = var_40779d0d;
  }

  function function_e3f38520(var_447b7d9b = 1) {
    var_76c10824 = var_447b7d9b;
  }

  function get_origin() {
    return var_4fc15b0b;
  }

  function function_f710ecd0() {
    var_4fc15b0b = var_e93e3086 + var_2df3d617;
    var_2d9de19e = var_3d18872 + var_21ab02f3;
  }

  function function_fbdfd5f9() {
    return {
      #enabled: var_76c10824, #var_71fe4b43: var_b228f30, #var_8d3781b5: var_89c30c57
    };
  }
}

function private autoexec __init__system__() {
  system::register(#"hash_19a39574bfda1b56", &preinit, undefined, undefined, undefined);
}

function function_5128ed40(var_56c2f5d3) {
  components = [];
  components = strtok(var_56c2f5d3, ",");

  if(!isDefined(components[0])) {
    components[0] = 0;
  }

  if(!isDefined(components[1])) {
    components[1] = 0;
  }

  if(!isDefined(components[2])) {
    components[2] = 0;
  }

  return (int(components[0]), int(components[1]), int(components[2]));
}

function private preinit() {
  var_5d7dbefc = new class_d5e68311();
  level.var_5d7dbefc = var_5d7dbefc;
  callback::on_localclient_connect(&on_localclient_connect);
}

function on_localclient_connect(localclientnum) {
  level thread function_3adc69b0(localclientnum);
}

function function_3adc69b0(localclientnum = 0) {
  level endon(#"disconnect");

  while(true) {
    waitresult = level waittill("CollectibleInspect" + localclientnum, #"collectibleinspect");

    switch (waitresult.event_name) {
      case # "start":
        if(isDefined(waitresult.origin) && isstring(waitresult.origin)) {
          waitresult.origin = function_5128ed40(waitresult.origin);
        }

        if(isDefined(waitresult.angle) && isstring(waitresult.angle)) {
          waitresult.angle = function_5128ed40(waitresult.angle);
        }

        function_98095ab5(localclientnum, waitresult.origin, waitresult.angle, waitresult.var_447b7d9b, waitresult.var_4c987939);
        break;
      case # "update_model":
        function_159ea549(waitresult.var_53008658, waitresult.is_hidden);
        break;
      case # "update_settings":
        if(isDefined(waitresult.origin) && isstring(waitresult.origin)) {
          waitresult.origin = function_5128ed40(waitresult.origin);
        }

        if(isDefined(waitresult.angle) && isstring(waitresult.angle)) {
          waitresult.angle = function_5128ed40(waitresult.angle);
        }

        function_24de0369(waitresult.origin, waitresult.angle, waitresult.var_447b7d9b, waitresult.var_4c987939);
        break;
      case # "stop":
        function_fdff8886();
        break;
    }
  }
}

function function_98095ab5(local_client_num, origin, angle, var_447b7d9b, var_4c987939) {
  level notify(#"hash_44d89707d01c9949");
  [[level.var_5d7dbefc]] - > function_b4ecf5f4(local_client_num, origin, angle, var_447b7d9b, var_4c987939);
  level thread function_aab851cf();
}

function function_159ea549(var_53008658, is_hidden) {
  [[level.var_5d7dbefc]] - > update_model(var_53008658, is_hidden);
}

function function_24de0369(origin, angle, var_447b7d9b, var_4c987939) {
  [[level.var_5d7dbefc]] - > update_settings(origin, angle, var_447b7d9b, var_4c987939);
}

function function_fdff8886() {
  level notify(#"hash_553672f4d62ba043");
  [[level.var_5d7dbefc]] - > reset();
}

function private function_5fb947f1(localclientnum) {
  input = (0, 0, 0);

  if(gamepadusedlast(localclientnum)) {
    right_stick = util::function_11f127f0(localclientnum);
    var_fc5fe2b2 = util::function_b5338ccb(right_stick.x, 0.2);
    var_a7ae3950 = util::function_b5338ccb(right_stick.y, 0.2);
    input = (var_fc5fe2b2, var_a7ae3950, 0);
  } else {
    input = function_6593be12(localclientnum) * (1, -1, 0);
  }

  return input;
}

function private function_58df12d3(localclientnum) {
  input = 0;

  if(gamepadusedlast(localclientnum)) {
    var_43bc2604 = util::function_57f1ac46(localclientnum);
    var_b16a628 = util::function_f35576c(localclientnum);
    input = var_43bc2604 - var_b16a628;
  } else {
    player = function_5c10bd79(localclientnum);
    input = getdvarfloat(#"hash_5dd7d8a561f705fe", 1) * (isDefined(player.var_5b9b8e89) ? player.var_5b9b8e89 : 0);
    player.var_5b9b8e89 = 0;
  }

  return input;
}

function private function_78e6ae5d() {
  while(isDefined(self)) {
    result = level waittill(#"collectiblezoom");

    if(isDefined(result.param1)) {
      player = function_5c10bd79([[self]] - > function_7c6cd9d());
      player.var_5b9b8e89 = int(result.param1);
    }
  }
}

function private function_aab851cf() {
  level endon(#"disconnect", #"hash_44d89707d01c9949", #"hash_553672f4d62ba043");
  level.var_5d7dbefc childthread function_78e6ae5d();

  while(isDefined(level.var_5d7dbefc)) {
    var_4ce74bd9 = [[level.var_5d7dbefc]] - > function_6e7ad37e();
    var_40779d0d = [[level.var_5d7dbefc]] - > function_62571daf();

    if(![[level.var_5d7dbefc]] - > function_75aa931a()) {
      waitframe(1);
      continue;
    }

    local_client_num = [[level.var_5d7dbefc]] - > function_7c6cd9d();
    player = function_5c10bd79(local_client_num);
    time = player getclienttime();
    waitframe(1);
    player = function_5c10bd79(local_client_num);
    delta_time = (player getclienttime() - time) / 1000;
    var_59ab9a62 = [[level.var_5d7dbefc]] - > function_fbdfd5f9();
    var_20eb713c = [[level.var_5d7dbefc]] - > function_13f1dc62();
    v_origin = [[level.var_5d7dbefc]] - > get_origin();
    v_angle = [[level.var_5d7dbefc]] - > get_angle();
    var_dbceb0e1 = 0;

    if(is_true(var_59ab9a62.enabled) && ![[level.var_5d7dbefc]] - > is_hidden()) {
      var_1b56e5cf = function_5fb947f1(local_client_num);

      if(var_1b56e5cf != (0, 0, 0)) {
        var_dbceb0e1 = 1;
        angle_offset = var_1b56e5cf * 60 * delta_time;
        yaw = angle_offset[0];
        pitch = angle_offset[1];
        v_angle += (pitch, yaw, 0);
        var_3faba1b8 = v_angle[1];
        clamped_pitch = v_angle[0];

        if(isDefined(var_59ab9a62.var_71fe4b43) && var_59ab9a62.var_71fe4b43 !== 0) {
          if(var_3faba1b8 < var_59ab9a62.var_71fe4b43 * -1) {
            var_3faba1b8 = var_59ab9a62.var_71fe4b43 * -1;
          } else if(var_3faba1b8 > var_59ab9a62.var_71fe4b43) {
            var_3faba1b8 = var_59ab9a62.var_71fe4b43;
          }
        }

        if(isDefined(var_59ab9a62.var_8d3781b5) && var_59ab9a62.var_8d3781b5 !== 0) {
          if(clamped_pitch < var_59ab9a62.var_8d3781b5 * -1) {
            clamped_pitch = var_59ab9a62.var_8d3781b5 * -1;
          } else if(clamped_pitch > var_59ab9a62.var_8d3781b5) {
            clamped_pitch = var_59ab9a62.var_8d3781b5;
          }
        }

        v_angle = (clamped_pitch, var_3faba1b8, 0);
      }
    }

    if(is_true(var_20eb713c.enabled) && ![[level.var_5d7dbefc]] - > is_hidden()) {
      var_a23c6f11 = function_58df12d3(local_client_num);

      if(var_a23c6f11 != 0) {
        var_dbceb0e1 = 1;
        var_cf138deb = 6;
        dist = v_origin[0] + var_a23c6f11 * var_cf138deb * delta_time;
        min_distance = var_4ce74bd9[0] - var_20eb713c.max;
        max_distance = var_4ce74bd9[0];

        if(dist < min_distance) {
          dist = min_distance;
        } else if(dist > max_distance) {
          dist = max_distance;
        }

        v_origin = (dist, v_origin[1], v_origin[2]);
      }
    }

    if(var_dbceb0e1 == 1) {
      [[level.var_5d7dbefc]] - > set_position(v_origin, v_angle);
    }

    time = player getclienttime();
  }
}