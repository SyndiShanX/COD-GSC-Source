/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\noisemaker.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace noisemaker;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &noisemakerfiremain);
}

function noisemakerfiremain(noisemaker, weapon) {
  if(!isDefined(noisemaker)) {
    return;
  }

  if(!isDefined(level.currentthrowobject)) {
    level.currentthrowobject = "";
  }

  noisemaker setModel(level.currentthrowobject);
  level.player notify("noisemaker_thrown", noisemaker);
  offhand = level.player getcurrentoffhand("secondaryoffhand");
  noisemaker waittill("missile_stuck", stuckto);

  foreach(ai in getaiarray("axis")) {
    if(isDefined(ai)) {
      var_aebcd718cc197d49 = distance(ai.origin, noisemaker.origin);

      if(var_aebcd718cc197d49 < 650) {
        ai aieventlistenerevent("cover_blown", level.player, noisemaker.origin);
      }
    }
  }

  var_ba9666bc2ced143f = spawn("script_model", noisemaker.origin);
  var_ba9666bc2ced143f.angles = noisemaker.angles;
  var_ba9666bc2ced143f setModel(level.currentthrowobject);
  var_ba9666bc2ced143f thread noisemakerwaitpickup(weapon);
  showcursor = 1;

  if(isDefined(level.allownoisemakerpickups) && !level.allownoisemakerpickups) {
    showcursor = 0;
  }

  if(showcursor) {
    noisemakersenablecursors();
  }

  noisemaker delete();
}

function noisemakersenablecursors() {
  if(!istrue(level.disablenoisemakers)) {
    noisemakerpickups = getEntArray("offhand_noisemaker", "targetname");

    foreach(var_ba9666bc2ced143f in noisemakerpickups) {
      if(isDefined(var_ba9666bc2ced143f.script_parameters)) {
        var_ba9666bc2ced143f.zoffset = stringtofloat(var_ba9666bc2ced143f.script_parameters);
      } else {
        var_ba9666bc2ced143f.zoffset = 1.5;
      }

      if(!isDefined(var_ba9666bc2ced143f.cursor_hint_ent)) {
        originoffset = rotatevectorinverted((0, 0, var_ba9666bc2ced143f.zoffset), var_ba9666bc2ced143f.angles);
        var_ba9666bc2ced143f scripts\sp\player\cursor_hint::create_cursor_hint(undefined, originoffset, &"CAPTIVE/CURSOR_PICKUP", 360, 128, 64);
      }
    }
  }
}

function noisemakersdisablecursors() {
  noisemakerpickups = getEntArray("offhand_noisemaker", "targetname");

  foreach(var_ba9666bc2ced143f in noisemakerpickups) {
    var_ba9666bc2ced143f scripts\sp\player\cursor_hint::remove_cursor_hint();
  }
}

function noisemakerwaitpickup(var_f71c752985ac24b1) {
  self endon("death");
  level.player notify("noisemaker_settled", self);
  self.targetname = "offhand_noisemaker";

  while(true) {
    self waittill("trigger");
    remainingammo = level.player getammocount(var_f71c752985ac24b1);

    if(remainingammo == 0) {
      level.currentthrowobject = self.model;
      level.player give_offhand("noisemaker");
      level.player notify("noisemaker_pickedup", self);
      noisemakersdisablecursors();
      self delete();
    }

    wait 0.5;
  }
}

function stringtofloat(stringval) {
  floatelements = strtok(stringval, ".");
  floatval = int(floatelements[0]);

  if(isDefined(floatelements[1])) {
    modifier = 1;

    for(i = 0; i < floatelements[1].size; i++) {
      modifier *= 0.1;
    }

    floatval += int(floatelements[1]) * modifier;
  }

  return floatval;
}