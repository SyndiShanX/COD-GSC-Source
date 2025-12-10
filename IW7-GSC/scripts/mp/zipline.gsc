/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\zipline.gsc
**********************************/

init() {
  var_00 = [];
  var_01 = getEntArray("zipline", "targetname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = scripts\mp\gameobjects::createuseobject("neutral", var_01[var_02], var_00, (0, 0, 0));
    var_03 scripts\mp\gameobjects::allowuse("any");
    var_03 scripts\mp\gameobjects::setusetime(0.25);
    var_03 scripts\mp\gameobjects::setusetext(&"MP_ZIPLINE_USE");
    var_03 scripts\mp\gameobjects::setusehinttext(&"MP_ZIPLINE_USE");
    var_03 scripts\mp\gameobjects::setvisibleteam("any");
    var_03.onbeginuse = ::onbeginuse;
    var_03.onuse = ::onuse;
    var_04 = [];
    var_05 = getent(var_01[var_02].target, "targetname");
    if(!isDefined(var_05)) {}

    while(isDefined(var_05)) {
      var_04[var_04.size] = var_05;
      if(isDefined(var_05.target)) {
        var_05 = getent(var_05.target, "targetname");
        continue;
      }

      break;
    }

    var_03.targets = var_04;
  }

  precachemodel("tag_player");
}

onbeginuse(param_00) {
  param_00 playSound("scrambler_pullout_lift_plr");
}

onuse(param_00) {
  param_00 thread func_13EFA(self);
}

func_13EFA(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("zipline_drop");
  level endon("game_ended");
  var_01 = spawn("script_origin", param_00.trigger.origin);
  var_01.origin = param_00.trigger.origin;
  var_01.angles = self.angles;
  var_01 setModel("tag_player");
  self playerlinktodelta(var_01, "tag_player", 1, 180, 180, 180, 180);
  thread func_139E8(var_01);
  thread func_13A06(var_01);
  var_02 = param_00.targets;
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = distance(var_01.origin, var_02[var_03].origin) / 600;
    var_05 = 0;
    if(var_03 == 0) {
      var_05 = var_04 * 0.2;
    }

    var_01 moveto(var_02[var_03].origin, var_04, var_05);
    if(var_01.angles != var_02[var_03].angles) {
      var_01 rotateto(var_02[var_03].angles, var_04 * 0.8);
    }

    wait(var_04);
  }

  self notify("destination");
  self unlink();
  var_01 delete();
}

func_13A06(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("destination");
  level endon("game_ended");
  self notifyonplayercommand("zipline_drop", "+gostand");
  self waittill("zipline_drop");
  self unlink();
  param_00 delete();
}

func_139E8(param_00) {
  self endon("disconnect");
  self endon("destination");
  self endon("zipline_drop");
  level endon("game_ended");
  self waittill("death");
  self unlink();
  param_00 delete();
}