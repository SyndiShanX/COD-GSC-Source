/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5cf0799d52c77e61.gsc
***********************************************/

#using script_17dcb1172e441bf6;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_634ae70c663d1cc9;
#using script_774302f762d76254;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_98036e8c;

function init() {}

function main() {
  level.doa.var_584a046 = [];
}

function function_f5114543() {
  self notify("4e7c7f84f1757943");
  self endon("4e7c7f84f1757943");
  self thread namespace_268747c0::function_978c05b5();
  result = self waittill(#"destroy_hazard");
  arrayremovevalue(level.doa.var_584a046, self);

  if(isDefined(self.script_model)) {
    self.script_model delete();
    self.script_model = undefined;
  }

  self setmovingplatformenabled(0);
}

function function_2c3d65c4(platform) {
  assert(isDefined(platform.target), "<dev string:x38>");

  if(!isDefined(platform.original_origin)) {
    platform.original_origin = platform.origin;
    toks = strtok(platform.script_parameters, ";");
    assert(toks.size >= 2, "<dev string:x58>");
    assert(toks[0] == "<dev string:xa3>" || toks[0] == "<dev string:xac>", "<dev string:xb8>");
    platform.type = toks[0] == "mover" ? 1 : 0;
    platform.duration = int(toks[1]);
    target = struct::get(platform.target, "targetname");

    if(platform.type == 0) {
      diffz = target.origin[2] - platform.origin[2];
      platform.destination = platform.origin + (0, 0, diffz);
    } else if(platform.type == 1) {
      diffx = target.origin[0] - platform.origin[0];
      var_289dea4a = target.origin[1] - platform.origin[1];

      if(diffx > var_289dea4a) {
        platform.destination = platform.origin + (diffx, 0, 0);
      } else {
        platform.destination = platform.origin + (0, var_289dea4a, 0);
      }
    }
  }

  platform.origin = platform.original_origin;
  platform setmovingplatformenabled(1);
  platform thread function_27b409b9();
  return platform;
}

function function_1ba8281d() {
  if(isDefined(level.doa.var_a77e6349)) {
    platforms = [[level.doa.var_a77e6349]] - > function_87f950c1("platform");
  } else {
    platforms = [[level.doa.var_39e3fa99]] - > function_242886d5("platform");
  }

  foreach(platform in platforms) {
    function_2c3d65c4(platform);
  }
}

function function_27b409b9() {
  self notify("177f39a01555cd50");
  self endon("177f39a01555cd50");
  level endon(#"game_over");
  self endon(#"destroy_hazard");
  self thread function_f5114543();

  while(true) {
    self moveto(self.destination, self.duration);
    self waittill(#"movedone");
    wait 1;
    self moveto(self.original_origin, self.duration);
    self waittill(#"movedone");
    wait 1;
  }
}