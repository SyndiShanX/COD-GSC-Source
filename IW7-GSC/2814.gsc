/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2814.gsc
***************************************/

init() {
  var_00 = [];
  var_01 = getEntArray("zipline", "targetname");

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_03 = scripts\mp\gameobjects::createuseobject("neutral", var_1[var_02], var_00, (0, 0, 0));
    var_03 scripts\mp\gameobjects::allowuse("any");
    var_03 scripts\mp\gameobjects::setusetime(0.25);
    var_03 scripts\mp\gameobjects::setusetext(&"MP_ZIPLINE_USE");
    var_03 scripts\mp\gameobjects::setusehinttext(&"MP_ZIPLINE_USE");
    var_03 scripts\mp\gameobjects::setvisibleteam("any");
    var_3.onbeginuse = ::onbeginuse;
    var_3.onuse = ::onuse;
    var_04 = [];
    var_05 = getent(var_1[var_02].target, "targetname");

    if(!isDefined(var_05)) {}

    while(isDefined(var_05)) {
      var_4[var_4.size] = var_05;

      if(isDefined(var_5.target)) {
        var_05 = getent(var_5.target, "targetname");
        continue;
      }

      break;
    }

    var_3.targets = var_04;
  }

  precachemodel("tag_player");
}

onbeginuse(var_00) {
  var_00 playSound("scrambler_pullout_lift_plr");
}

onuse(var_00) {
  var_00 thread func_13EFA(self);
}

func_13EFA(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("zipline_drop");
  level endon("game_ended");
  var_01 = spawn("script_origin", var_0.trigger.origin);
  var_1.origin = var_0.trigger.origin;
  var_1.angles = self.angles;
  var_01 setModel("tag_player");
  self getweightedchanceroll(var_01, "tag_player", 1, 180, 180, 180, 180);
  thread func_139E8(var_01);
  thread func_13A06(var_01);
  var_02 = var_0.targets;

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    var_04 = distance(var_1.origin, var_2[var_03].origin) / 600;
    var_05 = 0.0;

    if(var_03 == 0) {
      var_05 = var_04 * 0.2;
    }

    var_01 moveto(var_2[var_03].origin, var_04, var_05);

    if(var_1.angles != var_2[var_03].angles) {
      var_01 rotateto(var_2[var_03].angles, var_04 * 0.8);
    }

    wait(var_04);
  }

  self notify("destination");
  self unlink();
  var_01 delete();
}

func_13A06(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("destination");
  level endon("game_ended");
  self notifyonplayercommand("zipline_drop", "+gostand");
  self waittill("zipline_drop");
  self unlink();
  var_00 delete();
}

func_139E8(var_00) {
  self endon("disconnect");
  self endon("destination");
  self endon("zipline_drop");
  level endon("game_ended");
  self waittill("death");
  self unlink();
  var_00 delete();
}