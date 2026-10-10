/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\destructibles\oil_barrel.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\destructibles\barrel_common;
#using scripts\sp\utility;
#namespace oil_barrel;

function oil_barrel_init() {
  level.g_effect["oil_barrel_impact"] = loadfx("vfx/iw8/prop/scriptables/shared/vfx_imp_oil_stream.vfx");
  level.g_effect["oil_barrel_death"] = loadfx("vfx/iw8/prop/scriptables/vfx_oil_drum_big_01_s3.vfx");
  barrels = oil_get_barrels();

  foreach(barrel in barrels) {
    barrel thread oil_barrel();
  }
}

function oil_get_barrels() {
  return getEntArray("dyn_oil_barrel", "targetname");
}

function oil_barrel() {
  self endon("barrel_death");
  self endon("barrel_delete");
  barrel_setup("oil", 450, 250, 9100, 15000, 80, 28);
  self.health = 9450;

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon);

    if(!isvalidbarreldamage(attacker, type)) {
      continue;
    }

    if(!isDefined(type)) {
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
    var_b9bb95fbc1d74650 = spawn("script_origin", point);
    var_b9bb95fbc1d74650 linkTo(self);
    self notify("new_spew", tag);
    playFXOnTag(level.g_effect["oil_barrel_impact"], tag, "tag_origin");
    tag playSound("dst_oil_barrel_puncture_stream_start");
    var_b9bb95fbc1d74650 scalevolume(0, 0);
    var_b9bb95fbc1d74650 playLoopSound("dst_oil_barrel_puncture_stream_lp");
    var_b9bb95fbc1d74650 scalevolume(1, 0.25);
    var_b9bb95fbc1d74650 thread sfx_stop_oil_barrel_stream();
    self.spewtags = array_add(self.spewtags, tag);
    thread oilimpactlife(tag);
  }
}

function oilbarrelshoulddie(amount, attacker, type, objweapon) {
  if(isDefined(amount) && amount < 100) {
    return false;
  }

  if(isDefined(type)) {
    switch (type) {
      case #"hash_3c20f39c73a1422b":
      case #"hash_571e46e17a3cf2e3":
      case #"hash_66cb246f3e55fbe2":
      case #"hash_6df135435752c406":
      case #"hash_a911a1880d996edb":
      case #"hash_c22b13f81bed11f0":
        return true;
    }
  }

  return false;
}

function oilimpactlife(spewtag) {
  waittill_notify_or_timeout("entitydeleted", 5);

  if(isDefined(self)) {
    self.spewtags = array_remove(self.spewtags, spewtag);
  }

  spewtag delete();
}

function oil_barrel_death() {
  self notify("barrel_death");

  if(isDefined(self)) {
    self hide();
  }

  playFX(level.g_effect["oil_barrel_death"], self.origin);

  foreach(element in self.spewtags) {
    killfxontag(level.g_effect["oil_barrel_impact"], element, "tag_origin");
    waitframe();

    if(isDefined(element)) {
      element delete();
    }
  }

  if(isDefined(self)) {
    thread delay_delete(5);
  }
}

function delay_delete(time) {
  wait time;

  if(isDefined(self)) {
    self delete();
  }
}

function sfx_stop_oil_barrel_stream() {
  wait 3.3;
  fadeoutduration = 0.25;
  self playSound("dst_oil_barrel_puncture_stream_stop");
  self scalevolume(0, fadeoutduration);
  wait 0.3;
  self stoploopsound("dst_oil_barrel_puncture_stream_lp");
  self delete();
}