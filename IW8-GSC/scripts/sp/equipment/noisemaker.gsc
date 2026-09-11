/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\noisemaker.gsc
***********************************************/

function precache(var0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var0, &noisemakerfiremain);
}

function noisemakerfiremain(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(level.currentthrowobject)) {
    level.currentthrowobject = "";
  }

  var0 setModel(level.currentthrowobject);
  level.player notify("noisemaker_thrown", var0);
  var1 = level.player getcurrentoffhand("secondaryoffhand");
  var0 waittill("missile_stuck", var2);

  foreach(var4 in getaiarray("axis")) {
    if(isDefined(var4)) {
      var5 = distance(var4.origin, var0.origin);

      if(var5 < 650) {
        var4 aieventlistenerevent("cover_blown", level.player, var0.origin);
      }
    }
  }

  var7 = spawn("script_model", var0.origin);
  var7.angles = var0.angles;
  var7 setModel(level.currentthrowobject);
  thread noisemakerwaitpickup();
  var8 = 1;

  if(isDefined(level.allownoisemakerpickups) && !level.allownoisemakerpickups) {
    var8 = 0;
  }

  if(var8) {
    noisemakersenablecursors();
  }

  var0 delete();
}

function noisemakersenablecursors() {
  if(!istrue(level.disablenoisemakers)) {
    var0 = getEntArray("offhand_noisemaker", "targetname");

    foreach(var2 in var0) {
      if(isDefined(var2.script_parameters)) {
        var2.zoffset = stringtofloat(var2.script_parameters);
      } else {
        var2.zoffset = 1.5;
      }

      if(!isDefined(var2.cursor_hint_ent)) {
        var3 = rotatevectorinverted((0, 0, var2.zoffset), var2.angles);
        var2 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, var3, &"CAPTIVE/CURSOR_PICKUP", 360, 128, 64);
      }
    }

    return;
  }
}

function noisemakersdisablecursors() {
  var0 = getEntArray("offhand_noisemaker", "targetname");

  foreach(var2 in var0) {
    var2 scripts\sp\player\cursor_hint::remove_cursor_hint();
  }
}

function noisemakerwaitpickup() {
  self endon("death");
  level.player notify("noisemaker_settled", self);
  self.targetname = "offhand_noisemaker";

  for(;;) {
    self waittill("trigger");
    var0 = level.player getammocount("noisemaker");

    if(var0 == 0) {
      level.currentthrowobject = self.model;
      level.player scripts\engine\sp\utility::give_offhand("noisemaker");
      level.player notify("noisemaker_pickedup", self);
      noisemakersdisablecursors();
      self delete();
    }

    wait 0.5;
  }
}

function stringtofloat(var0) {
  var1 = strtok(var0, ".");
  var2 = int(var1[0]);

  if(isDefined(var1[1])) {
    var3 = 1;

    for(var4 = 0; var4 < var1[1].size; var4++) {
      var3 *= 0.1;
    }

    var2 += int(var1[1]) * var3;
  }

  return var2;
}