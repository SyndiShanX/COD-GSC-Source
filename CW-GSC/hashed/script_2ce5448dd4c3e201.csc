/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2ce5448dd4c3e201.csc
***********************************************/

#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_d150537f;

function init() {
  level.othervisuals = [];
  clientfield::register("scriptmover", "zone_id", 1, 5, "int", &function_b25b095f, 0, 0);
  clientfield::register("scriptmover", "zone_state", 1, 3, "int", &function_cb737c49, 0, 0);
  fields = getmapfields();
  level.var_117b4a3a = [];
  level.var_117b4a3a[0] = isDefined(fields.var_306136ca) ? fields.var_306136ca : # "hash_280d5153e1276d";
  level.var_117b4a3a[1] = isDefined(fields.var_e1ef0bf1) ? fields.var_e1ef0bf1 : # "hash_4b1a3a0285bea14d";
  level.var_117b4a3a[2] = isDefined(fields.var_97278b57) ? fields.var_97278b57 : # "hash_36a94457406aea0e";
  level.var_117b4a3a[3] = isDefined(fields.var_29209af9) ? fields.var_29209af9 : # "hash_5a60154937b01557";
  callback::on_spawned(&function_df78674f);
  callback::on_killcam_begin(&function_330a13a6);
  callback::on_killcam_end(&function_330a13a6);
  callback::add_callback(#"server_objective", &function_3022f6ba);
  setup_zones(0);
  level.var_5ff510b = [];
}

function setup_zones(local_client_num) {
  level.zones = [];
  triggers = getEntArray(local_client_num, "koth_zone_trigger", "targetname");
  triggers = arraycombine(triggers, getEntArray(local_client_num, "koth_zone_trigger", "script_noteworthy"));
  zones = struct::get_array("koth_zone_center", "targetname");

  foreach(zone in zones) {
    zone.state = 0;
    zone.trig = undefined;

    for(j = 0; j < triggers.size; j++) {
      if(triggers[j] istouching(zone.origin)) {
        zone.trig = triggers[j];
        zone.var_b76aa8 = j;
        break;
      }
    }

    level.zones[zone.script_index] = zone;
  }
}

function function_40990bae(local_client_num, obj_id, zone_index) {
  level.var_5ff510b[zone_index] = obj_id;
  function_dd2493cc(local_client_num, obj_id, zone_index);
}

function function_3022f6ba(eventstruct) {
  local_client_num = eventstruct.localclientnum;
  obj_id = eventstruct.id;
  ent = eventstruct.entity_num;

  if(isDefined(ent)) {
    ent.objectiveid = obj_id;
  }

  if(isDefined(ent.script_index)) {
    function_40990bae(local_client_num, obj_id, ent.script_index);
    return;
  }

  if(isDefined(level.var_5ff510b)) {
    foreach(script_index, objid in level.var_5ff510b) {
      if(objid == obj_id) {
        function_dd2493cc(local_client_num, obj_id, script_index);
      }
    }
  }
}

function function_dd2493cc(local_client_num, objid, zone_index) {
  iscodcaster = codcaster::function_b8fe9b52(local_client_num);

  if(iscodcaster) {
    var_4bb78aa3 = function_8147db19(local_client_num, objid, #"allies");
    var_c7fc4f01 = function_8147db19(local_client_num, objid, #"axis");
  } else {
    friendlyteam = function_9b3f0ed1(local_client_num);
    var_4bb78aa3 = function_8147db19(local_client_num, objid, friendlyteam);
    var_c7fc4f01 = function_6f7ac7fe(local_client_num, objid, friendlyteam);
  }

  suffix = iscodcaster ? "_codcaster" : "";
  state = 0;

  if(var_4bb78aa3) {
    state = 1;
  }

  if(var_c7fc4f01) {
    state = 2;
  }

  if(var_4bb78aa3 && var_c7fc4f01) {
    state = 3;
  }

  if(isDefined(level.othervisuals[zone_index])) {
    foreach(entid in level.othervisuals[zone_index]) {
      entity = getentbynum(local_client_num, entid);

      if(!isDefined(entity)) {
        continue;
      }

      for(si = 0; si < 4; si++) {
        rob = level.var_117b4a3a[si] + suffix;

        if(entity function_d2503806(rob)) {
          if(state != si) {
            entity stoprenderoverridebundle(rob);
          }

          continue;
        }

        if(state == si) {
          entity playrenderoverridebundle(rob);

          if(iscodcaster) {
            codcaster::function_773f6e31(local_client_num, entity, rob, state);
            continue;
          }

          util::function_f5b24d2d(local_client_num, entity, rob, state);
        }
      }
    }
  }
}

function function_330a13a6(params) {
  function_df78674f(params.localclientnum);
}

function function_df78674f(localclientnum) {
  if(isDefined(localclientnum)) {
    foreach(zone in level.zones) {
      obj_id = level.var_5ff510b[zone.script_index];

      if(!isDefined(obj_id)) {
        obj_id = serverobjective_getobjective(localclientnum, #"hardpoint");
      }

      if(isDefined(obj_id)) {
        function_dd2493cc(localclientnum, obj_id, zone.script_index);
      }
    }
  }
}

function function_cb737c49(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != fieldname) {
    zone = level.zones[self.script_index];

    if(isDefined(zone)) {
      zone.state = bwastimejump;
      zone function_9b650f0d(binitialsnap);
    }
  }
}

function function_b25b095f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != fieldname || !isDefined(self.script_index)) {
    script_index = bwastimejump;
    self.script_index = script_index;

    if(!isDefined(level.othervisuals[script_index])) {
      level.othervisuals[script_index] = [];
    }

    entnum = self getentitynumber();

    if(!isDefined(self.objectiveid)) {
      if(!isinarray(level.othervisuals[script_index], entnum)) {
        if(!isDefined(level.othervisuals[script_index])) {
          level.othervisuals[script_index] = [];
        } else if(!isarray(level.othervisuals[script_index])) {
          level.othervisuals[script_index] = array(level.othervisuals[script_index]);
        }

        if(!isinarray(level.othervisuals[script_index], entnum)) {
          level.othervisuals[script_index][level.othervisuals[script_index].size] = entnum;
        }

        iscodcaster = codcaster::function_b8fe9b52(binitialsnap);
        suffix = iscodcaster ? "_codcaster" : "";
        rob = level.var_117b4a3a[0] + suffix;

        if(!self function_d2503806(rob)) {
          self playrenderoverridebundle(rob);
        }

        if(iscodcaster) {
          codcaster::function_773f6e31(binitialsnap, self, rob, 0);
        } else {
          util::function_f5b24d2d(binitialsnap, self, rob, 0);
        }
      }

      return;
    }

    if(!isDefined(level.othervisuals[script_index])) {
      level.othervisuals[script_index] = [];
    } else if(!isarray(level.othervisuals[script_index])) {
      level.othervisuals[script_index] = array(level.othervisuals[script_index]);
    }

    if(!isinarray(level.othervisuals[script_index], entnum)) {
      level.othervisuals[script_index][level.othervisuals[script_index].size] = entnum;
    }

    function_40990bae(binitialsnap, self.objectiveid, script_index);
  }
}

function function_9b650f0d(local_client_num) {
  if(!isDefined(self.trig) || is_false(getgametypesetting(#"hash_4091f2d0019b1f4a"))) {
    return;
  }

  if(self.state == 1) {
    self.trig function_c06a8682(local_client_num);
    return;
  }

  self.trig function_c6c4ce9f(local_client_num);
}