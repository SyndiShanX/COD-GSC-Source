/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\oil_barrel.gsc
***************************************************/

#using scripts\engine\utility;
#using scripts\sp\destructibles\barrel_common;
#namespace oil_barrel;

function oil_barrel_init() {
  level.g_effect["P\xe2?\xd9 \xbcb[\xe7\xb5\x7fWj`\xd0\x91\xb6"] = loadfxasset("\xce%L\x80\x82\xce\x8d\xceL\xae\xca\x18\x80\xea\xae\xcc\x04m\xb9\x13.\n\xcc\xa0\x81\x9aP`O\adZ\xb6\xc4\xe3\xbc\xe0\xf0l\x80J\xefcA");
  level.g_effect["d\xd1|\xedec\xd3\x94\xb1\xa4\b><\xaf\xa3\xab"] = loadfxasset("g3\xc3\xd7\xb4\xee\x83\xfa\x1cNo\xe0\xafn\x8d\x9c\xd2\xe0\xa3\xfa\xedi\xd8\xeb\x19\xc9W\xb6\xaf\x13\xb4\xd9\xd7`L\xf5s\xcc");
  barrels = oil_get_barrels();

  foreach(barrel in barrels) {
    barrel thread oil_barrel();
  }
}

function oil_get_barrels() {
  return getEntArray("\x8f\x95\x9bIP\xf3\xbc<\xdd\xe8(\xb8\x9a\xe8", #targetname);
}

function oil_barrel() {
  self endon("m\xd9S\xb0\xae%\xc1dt&\xf9,");
  self endon("e]\x99l\xed\x9aV]x\xb5\xf9GP");
  barrel_common::barrel_setup("\x94!b", 450, 250, 9100, 15000, 80, 28);
  self.health = 9450;

  while(true) {
    self waittill("\fU`\xc0y\x95", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon);

    if(!barrel_common::isvalidbarreldamage(attacker, type)) {
      continue;
    }

    if(!isDefined(type)) {
      continue;
    }

    if(self.spewtags.size >= 4) {
      continue;
    }

    stringarray = strtok(type, "w");

    if(!arraycontains(stringarray, "\xd6\xcb\x8a\xd5\x8a\xb1")) {
      continue;
    }

    tag = utility::spawn_tag_origin(point);
    vec = vectorNormalize(self.origin - point);
    tagangles = vectortoangles(vec * -1);
    tag.angles = utility::flat_angle(tagangles);
    tag linkTo(self);
    self notify("\xc5\xbb!\xd1\x1d\xd3H\xe9", tag);
    playFXOnTag(level.g_effect["P\xe2?\xd9 \xbcb[\xe7\xb5\x7fWj`\xd0\x91\xb6"], tag, "\xec\xbfK|\au\xcd\xc2\x19<");

    if(soundexists("\f\xbe\x04N\xd8\xbb\xce\f\x9bbH\xe8B\xd4\xa0\xa4\xa5d$@\xff\x12\xb4\x9e|\xe0\xf3~\xa5|\xf3:\xb6\xdc{\x01\r$M\xddov=\x04\bA")) {
      tag playSound("\f\xbe\x04N\xd8\xbb\xce\f\x9bbH\xe8B\xd4\xa0\xa4\xa5d$@\xff\x12\xb4\x9e|\xe0\xf3~\xa5|\xf3:\xb6\xdc{\x01\r$M\xddov=\x04\bA");
    }

    if(soundexists("9\x97\x06\xeb\xcc\xd4(V\x93\xb1\x11\xd2\xe3\xff\x80\x04\x84\xf3PQ\xadN\f\x87\x87\x99\x81\x81\xe6\xa3\x1ff;\xdcG\"&\xfd\x9dC\x8f\xe3\x18")) {
      var_fbf9d650b44057b9 = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", point);
      var_fbf9d650b44057b9 linkTo(self);
      var_fbf9d650b44057b9 scalevolume(0, 0);
      var_fbf9d650b44057b9 playLoopSound("9\x97\x06\xeb\xcc\xd4(V\x93\xb1\x11\xd2\xe3\xff\x80\x04\x84\xf3PQ\xadN\f\x87\x87\x99\x81\x81\xe6\xa3\x1ff;\xdcG\"&\xfd\x9dC\x8f\xe3\x18");
      var_fbf9d650b44057b9 scalevolume(1, 0.25);
      var_fbf9d650b44057b9 thread sfx_stop_oil_barrel_stream();
    }

    self.spewtags = utility::array_add(self.spewtags, tag);
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
  utility::waittill_notify_or_timeout("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19", 5);

  if(isDefined(self)) {
    self.spewtags = arrayremove(self.spewtags, spewtag);
  }

  spewtag delete();
}

function oil_barrel_death() {
  self notify("m\xd9S\xb0\xae%\xc1dt&\xf9,");

  if(isDefined(self)) {
    self hide();
  }

  playFX(level.g_effect["d\xd1|\xedec\xd3\x94\xb1\xa4\b><\xaf\xa3\xab"], self.origin);

  foreach(element in self.spewtags) {
    killfxontag(level.g_effect["P\xe2?\xd9 \xbcb[\xe7\xb5\x7fWj`\xd0\x91\xb6"], element, "\xec\xbfK|\au\xcd\xc2\x19<");
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
  assert(soundexists("<dev string:x24>"));
  wait 3.3;
  fadeoutduration = 0.25;

  if(soundexists("#\xcd\xa3\xaf\xd8\xf6s\xa3\v\xb4\xdce\xe4_\xf6\xb4\x8d\xfa\xc4\x16N'\xac6\xbe\xc1W\xe6\xc6\xd1\xab\x9c\xca_7G'\xac\xc2\xd6\xfa7t\xed\a")) {
    self playSound("#\xcd\xa3\xaf\xd8\xf6s\xa3\v\xb4\xdce\xe4_\xf6\xb4\x8d\xfa\xc4\x16N'\xac6\xbe\xc1W\xe6\xc6\xd1\xab\x9c\xca_7G'\xac\xc2\xd6\xfa7t\xed\a");
    self scalevolume(0, fadeoutduration);
    wait 0.3;
    self stoploopsound("9\x97\x06\xeb\xcc\xd4(V\x93\xb1\x11\xd2\xe3\xff\x80\x04\x84\xf3PQ\xadN\f\x87\x87\x99\x81\x81\xe6\xa3\x1ff;\xdcG\"&\xfd\x9dC\x8f\xe3\x18");
  }

  waitframe();
  self delete();
}