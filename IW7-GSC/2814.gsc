/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2814.gsc
**************************************/

init() {
  var_0 = [];
  var_1 = getEntArray("zipline", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = scripts\mp\gameobjects::createuseobject("neutral", var_1[var_2], var_0, (0, 0, 0));
    var_3 scripts\mp\gameobjects::allowuse("any");
    var_3 scripts\mp\gameobjects::setusetime(0.25);
    var_3 scripts\mp\gameobjects::setusetext(&"MP_ZIPLINE_USE");
    var_3 scripts\mp\gameobjects::setusehinttext(&"MP_ZIPLINE_USE");
    var_3 scripts\mp\gameobjects::setvisibleteam("any");
    var_3.onbeginuse = ::onbeginuse;
    var_3.onuse = ::onuse;
    var_4 = [];
    var_5 = getent(var_1[var_2].target, "targetname");

    if(!isDefined(var_5)) {}

    while(isDefined(var_5)) {
      var_4[var_4.size] = var_5;

      if(isDefined(var_5.target)) {
        var_5 = getent(var_5.target, "targetname");
        continue;
      }

      break;
    }

    var_3.targets = var_4;
  }

  precachemodel("tag_player");
}

onbeginuse(var_0) {
  var_0 playSound("scrambler_pullout_lift_plr");
}

onuse(var_0) {
  var_0 thread func_13EFA(self);
}

func_13EFA(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("zipline_drop");
  level endon("game_ended");
  var_1 = spawn("script_origin", var_0.trigger.origin);
  var_1.origin = var_0.trigger.origin;
  var_1.angles = self.angles;
  var_1 setModel("tag_player");
  self getweightedchanceroll(var_1, "tag_player", 1, 180, 180, 180, 180);
  thread func_139E8(var_1);
  thread func_13A06(var_1);
  var_2 = var_0.targets;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = distance(var_1.origin, var_2[var_3].origin) / 600;
    var_5 = 0.0;

    if(var_3 == 0) {
      var_5 = var_4 * 0.2;
    }

    var_1 moveto(var_2[var_3].origin, var_4, var_5);

    if(var_1.angles != var_2[var_3].angles) {
      var_1 rotateto(var_2[var_3].angles, var_4 * 0.8);
    }

    wait(var_4);
  }

  self notify("destination");
  self unlink();
  var_1 delete();
}

func_13A06(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("destination");
  level endon("game_ended");
  self notifyonplayercommand("zipline_drop", "+gostand");
  self waittill("zipline_drop");
  self unlink();
  var_0 delete();
}

func_139E8(var_0) {
  self endon("disconnect");
  self endon("destination");
  self endon("zipline_drop");
  level endon("game_ended");
  self waittill("death");
  self unlink();
  var_0 delete();
}