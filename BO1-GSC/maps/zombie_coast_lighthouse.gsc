/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_coast_lighthouse.gsc
********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

init() {
  pack_a_punch_init();
  level thread lighthouse_wait_for_power();
  level thread hide_packapunch_at_beginning();
}

hide_packapunch_at_beginning() {
  wait(5);
  pack_a_punch_hide();
}

lighthouse_wait_for_power() {
  level waittill("power_on");
  clientnotify("LHL");
  while(1) {
    pack_a_punch_hide();
    wait(randomintrange(100, 120));
    clientnotify("lhfo");
    exploder(310);
    playsoundatposition("zmb_pap_lightning_1", (0, 0, 0));
    wait(15);
    exploder(310);
    playsoundatposition("zmb_pap_lightning_2", (0, 0, 0));
    clientnotify("lhfd");
    pack_a_punch_move_to_spot();
    wait(120);
    while(flag("pack_machine_in_use")) {
      wait .05;
    }
  }
}

pack_a_punch_init() {
  pap_machine_trig = getEnt("zombie_vending_upgrade", "targetname");
  pap_bump_trig = getEnt("pack_bump_trig", "script_noteworthy");
  pap_bump_trig enablelinkto();
  pap_machine_trig enablelinkto();
}

pack_a_punch_move_to_spot() {
  level.pap_moving = true;
  pap_clip = getEnt("zombie_vending_upgrade_clip", "targetname");
  pap_clip notsolid();
  pap_machine_trig = getEnt("zombie_vending_upgrade", "targetname");
  pap_pieces = getEntArray(pap_machine_trig.target, "targetname");
  pap_bump_trig = getEnt("pack_bump_trig", "script_noteworthy");
  pap_jingle_struct = getstruct("pack_jingle_struct", "script_noteworthy");
  link_ent = spawn("script_origin", pap_clip.origin);
  link_ent.angles = pap_jingle_struct.angles;
  pap_machine_trig linkto(link_ent);
  pap_bump_trig linkto(link_ent);
  pap_clip linkto(link_ent);
  for(i = 0; i < pap_pieces.size; i++) {
    if(isDefined(pap_pieces[i].target)) {
      getEnt(pap_pieces[i].target, "targetname") linkto(link_ent);
      getEnt(pap_pieces[i].target, "targetname") hide();
    }
    pap_pieces[i] linkto(link_ent);
    pap_pieces[i] hide();
  }
  link_ent moveTo(link_ent.origin + (0, 0, -1500), .5);
  new_spot = get_new_pack_spot();
  assertex(isDefined(new_spot.script_string), "structs placed for the packapunch machine neeed to have a script_string value to contain client notification string");
  level.current_pap_spot = new_spot;
  clientnotify(new_spot.script_string);
  link_ent moveTo(new_spot.origin + (0, 0, -350), .05);
  link_ent rotateto(new_spot.angles, .1);
  link_ent waittill("rotatedone");
  for(i = 0; i < pap_pieces.size; i++) {
    if(isDefined(pap_pieces[i].target)) {
      getEnt(pap_pieces[i].target, "targetname") show();
    }
    pap_pieces[i] show();
  }
  link_ent moveTo(new_spot.origin, 5);
  link_ent playSound("zmb_pap_rise");
  link_ent thread pap_rise_fx();
  link_ent thread pap_wobble();
  wait(1);
  level thread hide_pap_debris();
  do_packapunch_fx();
  link_ent waittill("movedone");
  wait(.3);
  link_ent rotateto(new_spot.angles, .2);
  link_ent waittill("rotatedone");
  pap_machine_trig unlink();
  pap_bump_trig unlink();
  for(i = 0; i < pap_pieces.size; i++) {
    if(isDefined(pap_pieces[i].target)) {
      getEnt(pap_pieces[i].target, "targetname") unlink();
    }
    pap_pieces[i] unlink();
  }
  pap_jingle_struct.origin = pap_bump_trig.origin;
  pap_jingle_struct.angles = link_ent.angles;
  pap_clip unlink();
  link_ent delete();
  level.pap_moving = undefined;
}

pap_wobble() {
  self endon("movedone");
  self.og_angles = self.angles;
  while(1) {
    self rotateto(self.og_angles + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(-10, 10)), .2);
    wait(.2);
  }
}

pap_rise_fx() {
  if(!isDefined(level.current_pap_spot)) {
    return;
  }
  switch (level.current_pap_spot.script_string) {
    case "pp0":
      exploder(212);
      break;
    case "pp1":
      exploder(211);
      break;
    case "pp2":
      exploder(213);
      break;
  }
}

get_new_pack_spot() {
  spots = getstructarray("pap_location", "targetname");
  if(isDefined(level.current_pap_spot)) {
    spots = array_remove(spots, level.current_pap_spot);
  }
  spot = random(spots);
  return spot;
}

do_packapunch_fx() {
  switch (level.current_pap_spot.script_string) {
    case "pp0":
      exploder(202);
      break;
    case "pp1":
      exploder(201);
      break;
    case "pp2":
      exploder(203);
      break;
  }
}

stop_packapunch_fx() {
  if(!isDefined(level.current_pap_spot)) {
    return undefined;
  }
  if(level.current_pap_spot.script_string == "pp0") {
    stop_exploder(202);
  } else if(level.current_pap_spot.script_string == "pp1") {
    stop_exploder(201);
  } else if(level.current_pap_spot.script_string == "pp2") {
    stop_exploder(203);
  }
}

pack_a_punch_hide() {
  level.pap_moving = true;
  stop_packapunch_fx();
  pap_clip = getEnt("zombie_vending_upgrade_clip", "targetname");
  pap_clip notsolid();
  pap_machine_trig = getEnt("zombie_vending_upgrade", "targetname");
  pap_pieces = getEntArray(pap_machine_trig.target, "targetname");
  pap_bump_trig = getEnt("pack_bump_trig", "script_noteworthy");
  pap_jingle_struct = getstruct("pack_jingle_struct", "script_noteworthy");
  link_ent = spawn("script_origin", pap_machine_trig.origin);
  link_ent.angles = pap_jingle_struct.angles;
  pap_machine_trig linkto(link_ent);
  pap_bump_trig linkto(link_ent);
  pap_clip linkto(link_ent);
  for(i = 0; i < pap_pieces.size; i++) {
    if(isDefined(pap_pieces[i].target)) {
      getEnt(pap_pieces[i].target, "targetname") linkto(link_ent);
    }
    pap_pieces[i] linkto(link_ent);
  }
  link_ent moveTo(link_ent.origin + (0, 0, -350), 5);
  link_ent playSound("zmb_pap_lower");
  link_ent thread pap_rise_fx();
  wait(1);
  level thread replace_pap_debris();
  link_ent waittill("movedone");
  link_ent moveTo(link_ent.origin + (0, 0, -1500), .05);
  link_ent waittill("movedone");
  for(i = 0; i < pap_pieces.size; i++) {
    if(isDefined(pap_pieces[i].target)) {
      getEnt(pap_pieces[i].target, "targetname") hide();
    }
    pap_pieces[i] hide();
  }
  pap_machine_trig unlink();
  pap_bump_trig unlink();
  for(i = 0; i < pap_pieces.size; i++) {
    if(isDefined(pap_pieces[i].target)) {
      getEnt(pap_pieces[i].target, "targetname") unlink();
    }
    pap_pieces[i] unlink();
  }
  pap_jingle_struct.origin = pap_machine_trig.origin;
  pap_jingle_struct.angles = link_ent.angles;
  pap_clip unlink();
  link_ent delete();
  level.pap_moving = undefined;
  clientnotify("PPH");
}

replace_pap_debris() {
  if(!isDefined(level.current_pap_spot)) {
    return undefined;
  }
  playFX(level._effect["rise_burst_water"], level.current_pap_spot.origin);
  debris = getEnt(level.current_pap_spot.target, "targetname");
  if(isDefined(debris)) {
    debris show();
    if(isDefined(debris._hidden)) {
      debris moveTo(debris.origin + (0, 0, 200), 3);
      debris._hidden = undefined;
    }
  }
}

hide_pap_debris() {
  if(!isDefined(level.current_pap_spot)) {
    return undefined;
  }
  playFX(level._effect["rise_burst_water"], level.current_pap_spot.origin);
  debris = getEnt(level.current_pap_spot.target, "targetname");
  if(isDefined(debris)) {
    debris._hidden = true;
    debris moveTo(debris.origin + (0, 0, -200), 3);
    wait(3);
    debris hide();
  }
}