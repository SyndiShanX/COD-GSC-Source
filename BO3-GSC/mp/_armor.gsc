/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_armor.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace armor;

function setlightarmorhp(newvalue) {
  if(isDefined(newvalue)) {
    self.lightarmorhp = newvalue;
    if(isPlayer(self) && isDefined(self.maxlightarmorhp) && self.maxlightarmorhp > 0) {
      lightarmorpercent = math::clamp(self.lightarmorhp / self.maxlightarmorhp, 0, 1);
      self setcontrolleruimodelvalue("hudItems.armorPercent", lightarmorpercent);
    }
  } else {
    self.lightarmorhp = undefined;
    self.maxlightarmorhp = undefined;
    self setcontrolleruimodelvalue("hudItems.armorPercent", 0);
  }
}

function setlightarmor(optionalarmorvalue) {
  self notify("give_light_armor");
  if(isDefined(self.lightarmorhp)) {
    unsetlightarmor();
  }
  self thread removelightarmorondeath();
  self thread removelightarmoronmatchend();
  if(isDefined(optionalarmorvalue)) {
    self.maxlightarmorhp = optionalarmorvalue;
  } else {
    self.maxlightarmorhp = 150;
  }
  self setlightarmorhp(self.maxlightarmorhp);
}

function removelightarmorondeath() {
  self endon("disconnect");
  self endon("give_light_armor");
  self endon("remove_light_armor");
  self waittill("death");
  unsetlightarmor();
}

function unsetlightarmor() {
  self setlightarmorhp(undefined);
  self notify("remove_light_armor");
}

function removelightarmoronmatchend() {
  self endon("disconnect");
  self endon("remove_light_armor");
  level waittill("game_ended");
  self thread unsetlightarmor();
}

function haslightarmor() {
  return isDefined(self.lightarmorhp) && self.lightarmorhp > 0;
}

function getarmor() {
  if(isDefined(self.lightarmorhp)) {
    return self.lightarmorhp;
  }
  return 0;
}