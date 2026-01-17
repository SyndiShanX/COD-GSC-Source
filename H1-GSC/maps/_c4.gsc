/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_c4.gsc
********************************/

main(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "weapon_c4";

  if(!isDefined(var_2))
    var_2 = "weapon_c4_obj";

  if(!isDefined(var_0))
    level.c4_weaponname = "c4";
  else
    level.c4_weaponname = var_0;

  precachemodel(var_1);
  precachemodel(var_2);
  precacheitem(level.c4_weaponname);

  if(isDefined(level.c4_explosion_fx_override))
    level._effect["c4_explosion"] = level.c4_explosion_fx_override;
  else
    level._effect["c4_explosion"] = loadfx("fx\explosions\grenadeExp_metal");
}

c4_location(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  if(!isDefined(var_4))
    var_4 = "weapon_c4";

  if(!isDefined(var_5))
    var_5 = "weapon_c4_obj";

  if(isDefined(var_0))
    var_6 = self gettagorigin(var_0);
  else if(isDefined(var_3))
    var_6 = var_3;
  else {}

  var_7 = spawn("script_model", var_6 + var_1);
  var_7 setModel(var_5);

  if(isDefined(var_0))
    var_7 linkto(self, var_0, var_1, var_2);
  else
    var_7.angles = self.angles;

  var_7.trigger = get_use_trigger();

  if(isDefined(level.c4_hintstring))
    var_7.trigger sethintstring(level.c4_hintstring);
  else
    var_7.trigger sethintstring(&"SCRIPT_PLATFORM_HINT_PLANTEXPLOSIVES");

  if(isDefined(var_0)) {
    var_7.trigger linkto(self, var_0, var_1, var_2);
    var_7.trigger.islinked = 1;
  } else
    var_7.trigger.origin = var_7.origin;

  var_7 thread handle_use(self, var_4);

  if(!isDefined(self.multiple_c4))
    var_7 thread handle_delete(self);

  var_7 thread handle_clear_c4(self);
  return var_7;
}

playc4effects() {
  self endon("death");
  wait 0.1;
  playFXOnTag(common_scripts\utility::getfx("c4_light_blink"), self, "tag_fx");
}

handle_use(var_0, var_1) {
  var_0 endon("clear_c4");

  if(!isDefined(var_1))
    var_1 = "weapon_c4";

  if(!isDefined(var_0.multiple_c4))
    var_0 endon("c4_planted");

  if(!isDefined(var_0.c4_count))
    var_0.c4_count = 0;

  var_0.c4_count++;
  self.trigger usetriggerrequirelookat();
  self.trigger waittill("trigger", var_2);
  level notify("c4_in_place", self);
  self.trigger unlink();
  self.trigger release_use_trigger();
  self playSound("c4_bounce_default");
  self setModel(var_1);
  thread playc4effects();
  var_0.c4_count--;

  if(!isDefined(var_0.multiple_c4) || !var_0.c4_count)
    var_2 switch_to_detonator();

  thread handle_detonation(var_0, var_2);
  var_0 notify("c4_planted", self);
}

handle_delete(var_0) {
  var_0 endon("clear_c4");
  self.trigger endon("trigger");
  var_0 waittill("c4_planted", var_1);
  self.trigger unlink();
  self.trigger release_use_trigger();
  self delete();
}

handle_detonation(var_0, var_1) {
  var_0 endon("clear_c4");
  var_1 waittill("detonate");
  playFX(level._effect["c4_explosion"], self.origin);
  var_2 = spawn("script_origin", self.origin);

  if(isDefined(level.c4_sound_override))
    var_2 playSound("detpack_explo_main", "sound_done");

  self radiusdamage(self.origin, 256, 200, 50);
  earthquake(0.4, 1, self.origin, 1000);

  if(isDefined(self))
    self delete();

  var_1 thread remove_detonator();
  var_0 notify("c4_detonation");
  var_2 waittill("sound_done");
  var_2 delete();
}

handle_clear_c4(var_0) {
  var_0 endon("c4_detonation");
  var_0 waittill("clear_c4");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.trigger.inuse) && self.trigger.inuse)
    self.trigger release_use_trigger();

  if(isDefined(self))
    self delete();

  level.player thread remove_detonator();
}

remove_detonator() {
  level endon("c4_in_place");
  wait 1;
  var_0 = 0;

  if(level.c4_weaponname == self getcurrentweapon() && isDefined(self.old_weapon)) {
    if(self.old_weapon == "none") {
      var_0 = 1;
      self switchtoweapon(self getweaponslistprimaries()[0]);
    } else if(self hasweapon(self.old_weapon) && self.old_weapon != level.c4_weaponname)
      self switchtoweapon(self.old_weapon);
    else
      self switchtoweapon(self getweaponslistprimaries()[0]);
  }

  self.old_weapon = undefined;

  if(0 != self getammocount(level.c4_weaponname)) {
    return;
  }
  self waittill("weapon_change");
  self takeweapon(level.c4_weaponname);
}

switch_to_detonator() {
  var_0 = undefined;

  if(!isDefined(self.old_weapon))
    self.old_weapon = self getcurrentweapon();

  var_1 = self getweaponslistall();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] != level.c4_weaponname) {
      continue;
    }
    var_0 = var_1[var_2];
  }

  if(!isDefined(var_0)) {
    self giveweapon(level.c4_weaponname);
    self setweaponammoclip(level.c4_weaponname, 0);
    self setactionslot(2, "weapon", level.c4_weaponname);
  }

  self switchtoweapon(level.c4_weaponname);
}

get_use_trigger() {
  var_0 = getEntArray("generic_use_trigger", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].inuse) && var_0[var_1].inuse) {
      continue;
    }
    if(!isDefined(var_0[var_1].inuse))
      var_0[var_1] enablelinkto();

    var_0[var_1].inuse = 1;
    var_0[var_1].oldorigin = var_0[var_1].origin;
    return var_0[var_1];
  }
}

release_use_trigger() {
  if(isDefined(self.islinked))
    self unlink();

  self.islinked = undefined;
  self.origin = self.oldorigin;
  self.inuse = 0;
}