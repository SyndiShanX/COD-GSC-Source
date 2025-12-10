/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_4f140352d4422a39.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace namespace_13b01f59;

autoexec __init__system__() {
  system::register(#"hash_4b6aad59587b2b51", &__init__, undefined, undefined);
}

__init__() {
  level.var_53022701 = isDefined(getgametypesetting(#"deathzones")) && getgametypesetting(#"deathzones");
  level.deathzones = [];
  level.var_5e1da61a = [];
  if(!level.var_53022701) {
    return;
  }
  clientfield::register("toplayer", "deathzonepostfx", 1, 1, "int", &function_90fd06c4, 0, 1);
  clientfield::register("toplayer", "deathzonewarningsound", 1, 2, "int", &function_5cdb5442, 0, 1);
  callback::on_localplayer_spawned(&on_localplayer_spawned);
}

function_302b7c90(localclientnum) {
  self endon(#"death");
  var_e95fa7e5 = createuimodel(getuimodelforcontroller(localclientnum), "locationText");
  var_a0534f4f = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.deathZones");
  var_b1862515 = createuimodel(var_a0534f4f, "towerIndex");
  var_6ecf939c = createuimodel(var_a0534f4f, "floorIndex");
  var_d1c2cd05 = undefined;
  while(isDefined(self)) {
    var_bd8e7ad0 = 0;
    foreach(targetname, zone in level.deathzones) {
      if(istouching(self.origin, zone.ent)) {
        if(var_d1c2cd05 !== targetname) {
          setuimodelvalue(var_e95fa7e5, zone.displayname);
          setuimodelvalue(var_b1862515, zone.towerindex);
          setuimodelvalue(var_6ecf939c, zone.floorIndex);
          var_d1c2cd05 = targetname;
        }
        var_bd8e7ad0 = 1;
        self function_983c4ea1(zone);
        break;
      }
    }
    if(!var_bd8e7ad0) {
      setuimodelvalue(var_e95fa7e5, # "");
      setuimodelvalue(var_b1862515, 0);
      setuimodelvalue(var_6ecf939c, 0);
      var_d1c2cd05 = undefined;
    }
    wait 0.5;
  }
}

on_localplayer_spawned(localclientnum) {
  if(self.localclientnum === localclientnum) {
    self thread function_302b7c90(localclientnum);
  }
}

private function_90fd06c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self codeplaypostfxbundle("pstfx_impending_collapse");
    return;
  }
  self codestoppostfxbundle("pstfx_impending_collapse");
}

private function_5cdb5442(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self function_27c0de81();
    self function_f425054c();
    return;
  }
  if(newval == 2) {
    self function_27c0de81();
    self function_a71ff4e6();
    return;
  }
  self function_b1ae60fb();
  self function_f425054c();
}

function_27c0de81() {
  if(!isDefined(self.var_a4408f28)) {
    self.var_a4408f28 = self playLoopSound(#"hash_4a7f02fe3ed6b2e3", 0.5);
  }
}

function_a71ff4e6() {
  if(!isDefined(self.var_92de59b7)) {
    self.var_92de59b7 = self playLoopSound(#"hash_225b6927fd97685c", 0.5);
  }
}

function_b1ae60fb() {
  if(isDefined(self.var_a4408f28)) {
    self stoploopsound(self.var_a4408f28, 2);
    self.var_a4408f28 = undefined;
  }
}

function_f425054c() {
  if(isDefined(self.var_92de59b7)) {
    self stoploopsound(self.var_92de59b7, 2);
    self.var_92de59b7 = undefined;
  }
}

event_handler[event_fecce913] function_facc1cf2(eventstruct) {
  if(!level.var_53022701) {
    return;
  }
  foreach(zone in level.deathzones) {
    if(zone.index == eventstruct.index) {
      setuimodelvalue(zone.var_7648e78f, eventstruct.state);
      if(eventstruct.state == 1) {
        zone.var_1b652cf4 = function_b71db9cf(eventstruct.localclientnum, zone);
      }
      foreach(player in getlocalplayers()) {
        if(istouching(player.origin, zone.ent)) {
          player function_983c4ea1(zone);
        }
      }
    }
  }
}

function_983c4ea1(zone) {
  if(isDefined(self.var_e8e77de) && self.var_bd04cab !== zone) {
    foreach(exit in self.var_e8e77de) {
      exit delete();
    }
    self.var_e8e77de = undefined;
  }
  self.var_bd04cab = zone;
  if(!isDefined(zone.var_1b652cf4) || isDefined(self.var_e8e77de)) {
    return;
  }
  self.var_e8e77de = [];
  localclientnum = self getlocalclientnumber();
  foreach(point in zone.var_1b652cf4) {
    exit = spawn(localclientnum, point, "script_model");
    exit setModel("p8_plaster_stucco_doorframe_01_56x96");
    exit playrenderoverridebundle(#"hash_1c90592671f4c6e9");
    exit thread bounce();
    self.var_e8e77de[self.var_e8e77de.size] = exit;
  }
}

bounce() {
  self endon(#"death");
  bottompos = self.origin;
  toppos = self.origin + (0, 0, 50);
  while(true) {
    self rotateyaw(180, 1);
    wait 1;
    self rotateyaw(180, 1);
    wait 1;
  }
}

init(targetname, displayname = # "", var_717ae355 = # "", var_19c57490, towerindex, floorIndex, var_7609462b) {
  ent = getent(0, targetname, "targetName");
  if(!isDefined(ent)) {
    level.var_7acdf658 = (isDefined(level.var_7acdf658) ? level.var_7acdf658 : 0) + 1;
    level.var_29a44241 = (isDefined(level.var_29a44241) ? level.var_29a44241 : "<dev string:x30>") + targetname + "<dev string:x31>";

      return;
  }
  var_5776c240 = createuimodel(var_7609462b, floorIndex);
  setuimodelvalue(createuimodel(var_5776c240, "floorIndex"), floorIndex);
  var_7648e78f = createuimodel(var_5776c240, "state");
  setuimodelvalue(var_7648e78f, 0);
  zone = {
    #ent: ent,
    #index: level.deathzones.size,
    #links: [],
    #displayname: displayname,
    #var_717ae355: var_717ae355,
    #towerindex: towerindex,
    #var_7648e78f: var_7648e78f,
    #floorIndex: floorIndex,
    #var_19c57490: var_19c57490
  };
  level.deathzones[targetname] = zone;
  if(isDefined(var_19c57490)) {
    level.deathzones[var_19c57490].var_3f5ebc94 = targetname;
  }
  function_c7277786(zone);
}

link(var_d12d8e58, var_4334fd93) {
  var_d94ee2bc = level.deathzones[var_d12d8e58];
  var_4b5651f7 = level.deathzones[var_4334fd93];
  if(!isDefined(var_d94ee2bc) || !isDefined(var_4b5651f7)) {
    return;
  }
  if(!isinarray(var_d94ee2bc.links, var_4b5651f7)) {
    var_d94ee2bc.links[var_d94ee2bc.links.size] = var_4b5651f7;
  }
  if(!isinarray(var_4b5651f7.links, var_d94ee2bc)) {
    var_4b5651f7.links[var_4b5651f7.links.size] = var_d94ee2bc;
  }
}

function_c7277786(zone) {
  targets = struct::get_array(zone.ent.target, "targetname");
  targetpoints = [];
  foreach(target in targets) {
    targetpoints[targetpoints.size] = target.origin;
    arrayremovevalue(level.struct, target, 1);
  }
  arrayremovevalue(level.struct, undefined, 0);
  zone.targetpoints = targetpoints;
}

init_zones() {
  var_648e4b40 = createuimodel(getglobaluimodel(), "hudItems.deathZones");
  towerindex = 0;
  foreach(tower in level.var_7045f0c9.var_83ddbbac) {
    linkAdjacentFloors = isDefined(tower.linkAdjacentFloors) ? tower.linkAdjacentFloors : 0;
    towerindex += 1;
    var_7609462b = createuimodel(var_648e4b40, towerindex);
    setuimodelvalue(createuimodel(var_7609462b, "displayName"), tower.var_717ae355);
    setuimodelvalue(createuimodel(var_7609462b, "linkAdjacentFloors"), linkAdjacentFloors);
    setuimodelvalue(createuimodel(var_7609462b, "numFloors"), tower.var_f232f67f.size);
    var_69901428 = undefined;
    for(i = 0; i < tower.var_f232f67f.size; i++) {
      floor = tower.var_f232f67f[i];
      init(floor.targetname, floor.displayname, tower.var_717ae355, var_69901428, towerindex, tower.var_f232f67f.size - i, var_7609462b);
      if(linkAdjacentFloors && isDefined(var_69901428)) {
        link(var_69901428, floor.targetname);
      }
      var_69901428 = floor.targetname;
    }
  }
  foreach(var_fec0ded7 in level.var_7045f0c9.var_2bf81182) {
    link(var_fec0ded7.var_f1a48208, var_fec0ded7.var_63abf143);
  }

  if(isDefined(level.var_7acdf658)) {
    errormsg(level.var_7acdf658 + "<dev string:x34>" + level.var_29a44241);
  }

}

function_b5dcecdd(targetname) {
  targets = getEntArray(0, targetname, "targetname");
  foreach(target in targets) {
    level.var_5e1da61a[level.var_5e1da61a.size] = target;
  }
}

function_b71db9cf(localclientnum, zone) {
  points = [];
  foreach(var_76648ef0 in level.var_5e1da61a) {
    point = function_7162d244(localclientnum, zone, var_76648ef0);
    if(function_bf2cf692(localclientnum, zone, var_76648ef0, point)) {
      points[points.size] = point;
    }
  }
  return points;
}

function_7162d244(localclientnum, zone, var_76648ef0) {
  var_bb1ad81f = zone.ent getabsmins()[2] + 1;
  point = (var_76648ef0.origin[0], var_76648ef0.origin[1], var_bb1ad81f);
  point += vectornormalize(zone.ent.origin - point);
  return point;
}

function_bf2cf692(localclientnum, zone, var_76648ef0, exitpoint) {
  if(!istouching(exitpoint, zone.ent) || !istouching(exitpoint, var_76648ef0)) {
    return false;
  }
  foreach(var_8563d934 in zone.links) {
    if(function_fc3ab3fc(localclientnum, var_8563d934.index) == 2) {
      continue;
    }
    point = function_7162d244(localclientnum, var_8563d934, var_76648ef0);
    if(istouching(point, var_8563d934.ent) && istouching(point, var_76648ef0)) {
      return true;
    }
  }
  return false;
}