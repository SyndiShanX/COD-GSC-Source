/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\noisemaker.gsc
***********************************************/

precache(var_0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, ::noisemakerfiremain);
}

noisemakerfiremain(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.currentthrowobject))
    level.currentthrowobject = "";

  var_0 setModel(level.currentthrowobject);
  level.player notify("noisemaker_thrown", var_0);
  var_1 = level.player getcurrentoffhand("secondaryoffhand");
  var_0 waittill("missile_stuck", var_2);

  foreach(var_4 in getaiarray("axis")) {
    if(isDefined(var_4)) {
      var_5 = distance(var_4.origin, var_0.origin);

      if(var_5 < 650)
        var_4 aieventlistenerevent("cover_blown", level.player, var_0.origin);
    }
  }

  var_7 = spawn("script_model", var_0.origin);
  var_7.angles = var_0.angles;
  var_7 setModel(level.currentthrowobject);
  var_7 thread noisemakerwaitpickup();
  var_8 = 1;

  if(isDefined(level.allownoisemakerpickups) && !level.allownoisemakerpickups)
    var_8 = 0;

  if(var_8)
    noisemakersenablecursors();

  var_0 delete();
}

noisemakersenablecursors() {
  if(!istrue(level.disablenoisemakers)) {
    var_0 = getEntArray("offhand_noisemaker", "targetname");

    foreach(var_2 in var_0) {
      if(isDefined(var_2.script_parameters))
        var_2.zoffset = stringtofloat(var_2.script_parameters);
      else
        var_2.zoffset = 1.5;

      if(!isDefined(var_2.cursor_hint_ent)) {
        var_3 = rotatevectorinverted((0, 0, var_2.zoffset), var_2.angles);
        var_2 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, var_3, &"CAPTIVE/CURSOR_PICKUP", 360, 128, 64);
      }
    }
  }
}

noisemakersdisablecursors() {
  var_0 = getEntArray("offhand_noisemaker", "targetname");

  foreach(var_2 in var_0)
  var_2 scripts\sp\player\cursor_hint::remove_cursor_hint();
}

noisemakerwaitpickup() {
  self endon("death");
  level.player notify("noisemaker_settled", self);
  self.targetname = "offhand_noisemaker";

  for(;;) {
    self waittill("trigger");
    var_0 = level.player getammocount("noisemaker");

    if(var_0 == 0) {
      level.currentthrowobject = self.model;
      level.player scripts\engine\sp\utility::give_offhand("noisemaker");
      level.player notify("noisemaker_pickedup", self);
      noisemakersdisablecursors();
      self delete();
    }

    wait 0.5;
  }
}

stringtofloat(var_0) {
  var_1 = strtok(var_0, ".");
  var_2 = int(var_1[0]);

  if(isDefined(var_1[1])) {
    var_3 = 1;

    for(var_4 = 0; var_4 < var_1[1].size; var_4++)
      var_3 = var_3 * 0.1;

    var_2 = var_2 + int(var_1[1]) * var_3;
  }

  return var_2;
}