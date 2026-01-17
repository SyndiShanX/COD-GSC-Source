/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_c4.gsc
********************************************************/

/*
	Radiant:
		Create as many trigger_use with targetname "generic_use_trigger" as you might need. 8x8x8 units or so.
		Make sure to place them where the player can't get to them, they will be moved to the correct loctaion in script.
		They will be reused so you only have to do as many as you might have C4 objectivs active at the same time.
	
	Script:
		maps\_c4::main(); // Add in you main() function.
		<entity> maps\_c4::c4_location( tag, origin_offset, angles_offset, org );

		org => optional parameter if you want to plant on an origin instead of a tag

		<entity>.multiple_c4 = true;
		Set .multiple_c4 on the entity if more then one C4 in required before the detonator is given to the player.
		This must be set before <entity> maps\_c4::c4_location( ... ); is called.

	Example:
		technical = maps\_vehicle::waittill_vehiclespawn( "technical" );
		technical maps\_c4::c4_location( "tag_origin", (76, 15, 55.5), (11, 0, 1.5) );
		technical waittill( "c4_detonation" );
		technical notify( "death" ); // this does the explosion and model swap for a vehicle. Other entities might need other ways to do the model swap.

	If the target gets destroyed by something elese then the C4:
		<entity> notify( "clear_c4" ); // this will remove the c4 without detonation.

	You can have more then one c4_location on any one entity. Once one is triggered the others will be deleted.

*/
#include maps\_utility;
#include common_scripts\utility;

main() {
  precacheModel("weapon_c4");
  precacheModel("weapon_c4_obj");
  precacheItem("c4");
  level._effect["c4_explosion"] = loadfx("explosions/grenadeExp_metal");
}

c4_location(tag, origin_offset, angles_offset, org) {
  //self ---> the entity the c4 is placed on
  tag_origin = undefined;

  if(!isDefined(origin_offset))
    origin_offset = (0, 0, 0);
  if(!isDefined(angles_offset))
    angles_offset = (0, 0, 0);

  if(isDefined(tag))
    tag_origin = self gettagorigin(tag);
  else if(isDefined(org))
    tag_origin = org;
  else
    assertmsg("need to specify either a 'tag' or an 'org' parameter to attach the c4 to");

  c4_model = spawn("script_model", tag_origin + origin_offset);
  c4_model setModel("weapon_c4_obj");

  if(isDefined(tag))
    c4_model linkto(self, tag, origin_offset, angles_offset);
  else
    c4_model.angles = self.angles;

  c4_model.trigger = get_use_trigger();
  // Press and hold && 1 to plant the explosives.
  c4_model.trigger sethintstring(&"SCRIPT_PLATFORM_HINT_PLANTEXPLOSIVES");

  if(isDefined(tag)) {
    c4_model.trigger linkto(self, tag, origin_offset, angles_offset);
    c4_model.trigger.islinked = true;
  } else
    c4_model.trigger.origin = c4_model.origin;

  c4_model thread handle_use(self);
  if(!isDefined(self.multiple_c4))
    c4_model thread handle_delete(self);
  c4_model thread handle_clear_c4(self);

  return c4_model;
}

playC4Effects() {
  self endon("death");

  wait .1;

  playFXOnTag(getfx("c4_light_blink"), self, "tag_fx");
}

handle_use(c4_target) {
  //self ==> the c4 model
  //c4_target ==> the entity the c4 is placed on
  c4_target endon("clear_c4");

  if(!isDefined(c4_target.multiple_c4))
    c4_target endon("c4_planted");

  if(!isDefined(c4_target.c4_count))
    c4_target.c4_count = 0;

  c4_target.c4_count++;

  self.trigger usetriggerrequirelookat();
  self.trigger waittill("trigger", player);

  level notify("c4_in_place", self);

  self.trigger unlink();
  self.trigger release_use_trigger();

  self playSound("c4_bounce_default");
  self setModel("weapon_c4");

  self thread playC4Effects();

  c4_target.c4_count--;

  if(!isDefined(c4_target.multiple_c4) || !c4_target.c4_count)
    player switch_to_detonator();

  self thread handle_detonation(c4_target, player);

  c4_target notify("c4_planted", self);
}

handle_delete(c4_target) {
  c4_target endon("clear_c4");
  self.trigger endon("trigger");

  c4_target waittill("c4_planted", c4_model);
  self.trigger unlink();
  self.trigger release_use_trigger();
  self delete();
}

handle_detonation(c4_target, player) {
  c4_target endon("clear_c4");

  player waittill("detonate");
  playFX(level._effect["c4_explosion"], self.origin);

  soundPlayer = spawn("script_origin", self.origin);

  if(isDefined(level.c4_sound_override))
    soundPlayer playSound("detpack_explo_main", "sound_done");

  self radiusdamage(self.origin, 256, 200, 50);
  earthquake(0.4, 1, self.origin, 1000);

  if(isDefined(self))
    self delete();

  player thread remove_detonator();

  c4_target notify("c4_detonation");

  soundPlayer waittill("sound_done"); // not working?
  soundPlayer delete();
}

handle_clear_c4(c4_target) {
  //self ==> the c4 model
  //c4_target ==> the entity the c4 is placed on
  c4_target endon("c4_detonation");

  c4_target waittill("clear_c4");

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

  had_empty_old_weapon = false;
  if("c4" == self getcurrentweapon() && (isDefined(self.old_weapon))) {
    if(self.old_weapon == "none") {
      had_empty_old_weapon = true;
      self switchtoweapon(self GetWeaponsListPrimaries()[0]);
    } else {
      if((self HasWeapon(self.old_weapon)) && (self.old_weapon != "c4"))
        self switchtoweapon(self.old_weapon);
      else
        self switchtoweapon(self GetWeaponsListPrimaries()[0]);
    }
  }

  self.old_weapon = undefined;

  if(0 != self getammocount("c4")) {
    return;
  }
  self waittill("weapon_change");
  self takeweapon("c4");
}

switch_to_detonator() {
  c4_weapon = undefined;
  if(!isDefined(self.old_weapon))
    self.old_weapon = self getcurrentweapon();

  // if the player doesn't have the C4 weapon give it to him.
  weapons = self GetWeaponsListAll();
  for(i = 0; i < weapons.size; i++) {
    if(weapons[i] != "c4")
      continue;
    c4_weapon = weapons[i];
  }
  if(!isDefined(c4_weapon)) {
    self giveWeapon("c4");
    self SetWeaponAmmoClip("c4", 0);
    self SetActionSlot(2, "weapon", "c4");
  }

  self switchtoweapon("c4");
}

get_use_trigger() {
  ents = getEntArray("generic_use_trigger", "targetname");
  assertex(isDefined(ents) && ents.size > 0, "Missing use trigger with targetname: generic_use_trigger.");
  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].inuse) && ents[i].inuse)
      continue;
    if(!isDefined(ents[i].inuse))
      ents[i] enablelinkto();
    ents[i].inuse = true;
    ents[i].oldorigin = ents[i].origin;
    return ents[i];
  }
  assertmsg("all generic use triggers are in use. Place more of them in the map.");
}

release_use_trigger() {
  if(isDefined(self.islinked))
    self unlink();
  self.islinked = undefined;
  self.origin = self.oldorigin;
  self.inuse = false;
}