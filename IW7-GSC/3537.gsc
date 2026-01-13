/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3537.gsc
***************************************/

func_E814() {
  if(!isDefined(self.hasrearguardshield)) {
    var_0 = self gettagorigin("tag_shield_back");
    var_1 = spawn("script_origin", var_0);
    var_1 linkto(self, "tag_shield_back");
    self attachshieldmodel("weapon_rearguard_shield_wm_mp", "tag_shield_back");
    self.hasrearguardshield = 1;
    self.rearguardattackers = [];
    self setclientomnvar("ui_dodge_charges", 6);
    var_1 thread func_D415(self);
    var_1 thread func_D416(self);
    var_1 thread func_13A34(self);
    var_1 setotherent(self);
    var_1 setCanDamage(1);
  }
}

func_13A34(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("remove_rearguard");
  self endon("death");

  if(level.hardcoremode) {
    var_1 = 10;
  } else {
    var_1 = 30;
  }

  while(var_0.var_FC96 < var_1) {
    wait 0.05;
  }

  func_E168("damaged", var_0);
}

func_D416(var_0) {
  self endon("disconnect");
  self endon("death");
  var_0 waittill("death");
  func_E168("died", var_0);
}

func_D415(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  func_E168("disconnect", var_0);
}

func_E168(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(var_1) && scripts\mp\utility\game::istrue(var_1.hasrearguardshield) && var_0 == "damaged") {
    var_1 detachshieldmodel("weapon_rearguard_shield_wm_mp", "tag_shield_back");
  }

  if(var_0 != "disconnect") {
    var_1 setclientomnvar("ui_dodge_charges", 0);
  }

  waittillframeend;
  self notify("death");
  self delete();
}