/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\destructibles\log_pile.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\destructibles\barrel_common;
#using scripts\sp\utility;
#namespace log_pile;

function log_pile_init() {
  piles = getEntArray("dyn_log_pile", "targetname");

  if(piles.size <= 0) {
    return;
  }

  level.g_effect["log_pile_impact"] = loadfx("vfx/jup/prop/scriptables/vfx_jup_log_shrapnel_01.vfx");

  for(i = 0; i < piles.size; i++) {
    piles[i] setCanDamage(1);
    piles[i].spewtags = [];
    piles[i] thread log_pile();
  }
}

function log_pile() {
  self endon("entitydeleted");

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon);

    if(!isDefined(type)) {
      continue;
    }

    if(ismeleedamage(type)) {
      continue;
    }

    if(self.spewtags.size >= 4) {
      continue;
    }

    stringarray = strtok(type, "_");

    if(!array_contains(stringarray, "BULLET")) {
      continue;
    }

    tag = spawn_tag_origin(point);
    vec = vectorNormalize(self.origin - point);
    tagangles = vectortoangles(vec * -1);
    tag.angles = flat_angle(tagangles);
    tag linkTo(self);
    self notify("new_spew", tag);
    playFXOnTag(level.g_effect["log_pile_impact"], tag, "tag_origin");
    self.spewtags = array_add(self.spewtags, tag);
    thread function_3289f7ed667e369c(tag);
  }
}

function function_3289f7ed667e369c(spewtag) {
  waittill_notify_or_timeout("entitydeleted", 5);

  if(isDefined(self)) {
    self.spewtags = array_remove(self.spewtags, spewtag);
  }

  spewtag delete();
}