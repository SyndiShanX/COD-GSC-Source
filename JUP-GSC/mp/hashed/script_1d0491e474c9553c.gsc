/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1d0491e474c9553c.gsc
*************************************************/

#using script_4c543f01345a2c04;
#using script_6de180c937bb3129;
#using script_7edf952f8921aa6b;
#using script_da0dce9d411d119;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace zombie_entity;

function autoexec main() {
  var_601bcee5d276f46d = "zombie_entity";
  function_d6736c5ef5ac2990(var_601bcee5d276f46d, &function_3d588dcd552b26db);
}

function init_metabones() {
  setdvarifuninitialized(@ "hash_9dd191a7e11820fd", 0);
  thread function_995a6309e572cf14();
}

function function_3d588dcd552b26db(params) {
  metabone_name = params.metabone_name;
  index = get_weakpoint_index(metabone_name);

  if(index == -1) {
    return;
  }

  name = metabone_name + "_weakpoint";
  utility::function_3677f2be30fdd581(name, "destroyed");
  self.entitydata.var_21544f0d5a3ef4d2 -= 1;
  self.entitydata.weakpoints[index].state = "destroyed";

  if(self.entitydata.var_21544f0d5a3ef4d2 <= 0) {
    if(self.entitydata.phase != "phase2vul") {
      function_f40c1634cd048cda(2);
    } else {
      function_f40c1634cd048cda(3);
    }

    if(function_1017131041e2a7b()) {
      self.entitydata.desiredstate = 1;
      self.var_e198ad98b4845f29.reason = "weakpoint";
    }
  }
}

function private function_995a6309e572cf14() {
  self endon("<dev string:x1c>");

  while(true) {
    metabones_def = function_97fd256a244527b4(self.metabones.bundle_name);

    foreach(metabone in metabones_def.metabones) {
      foreach(tag in metabone.tags) {
        is_active = function_6db512214e7e7009(metabone.name + "<dev string:x25>");
        draw_tag(tag.tagname, tag.radius, is_active);
      }
    }

    waitframe();
  }
}

function private draw_tag(tagname, tag_radius, is_active) {
  tag_origin = self gettagorigin(tagname);
  tag_angles = self gettagangles(tagname);
  function_ad6307798215e0be(tagname + "<dev string:x33>" + tag_angles[0] + "<dev string:x3a>" + tag_angles[1] + "<dev string:x3a>" + tag_angles[2], tag_origin, tag_radius, is_active);
}

function private function_ad6307798215e0be(text, pos, radius, is_active) {
  debug_val = getdvarint(@ "hash_9dd191a7e11820fd", 0);

  if(debug_val > 0) {
    pos = default_to(pos, self.origin + (0, 0, 70));
    color = (1, 0, 0);

    if(is_active) {
      color = (0, 1, 0);
    }

    var_db334a0ef5cf7571 = debug_val == 1;

    if(!var_db334a0ef5cf7571) {
      var_db334a0ef5cf7571 = is_active;
    }

    if(var_db334a0ef5cf7571) {
      print3d(pos, "<dev string:x3f>" + text, color);
      sphere(pos, radius, color);
    }
  }
}

# /