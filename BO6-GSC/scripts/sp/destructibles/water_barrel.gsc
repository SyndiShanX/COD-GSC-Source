/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\water_barrel.gsc
*****************************************************/

#using scripts\engine\utility;
#using scripts\sp\destructibles\barrel_common;
#namespace water_barrel;

function water_barrel_init() {
  level.g_effect["\xfa\x8c\xa9m!\xdbk\x15z\xe411R\xd1rXaOz"] = loadfxasset("l\xe5\x88\x01b\x878\xc8\x03B\x04\x16N\x18\xe8m\xab\xf3Ho\x1atQ\x83F\xc4\ab\xc9\b\xea-\xec\xdcX\xf9\x16\xa4\xd2\xc8\xc3\xc4\xd7R\xf8\xd9");
  level.g_effect["\x05\xd4\x14 \"a\r'\xbf\x8d\xa0\xdc\xf1\x9b\xc8\xcde\xa0"] = loadfxasset("\t|\xbaUI|g$\xf4\xecA\xc8N\xda\x90\x9d;\xc3Z\x8a3\x7fB\xe5Z\xc6\x96\xc5\xa2\\#x\x80\xf3\xb6\xe6MZK\x9d\xae\x12~ha\x13zx\xf7\xa1\x19\x96\xae\x9f\xb3-\x7f");
  barrels = getEntArray("d/\xcd\xebw\xc2\xa3\x959\xbe\x13X\xe4\x9cV\x1b", #targetname);

  foreach(barrel in barrels) {
    barrel thread water_barrel();
  }
}

function water_barrel() {
  self endon("m\xd9S\xb0\xae%\xc1dt&\xf9,");
  self endon("e]\x99l\xed\x9aV]x\xb5\xf9GP");
  barrel_common::barrel_setup("\x8d:N\x8d\xc1", 450, 250, 9100, 15000, 80, 28);
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
    var_c65c72427f12968 = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", point);
    var_c65c72427f12968 linkTo(self);
    self notify("\xc5\xbb!\xd1\x1d\xd3H\xe9", tag);
    playFXOnTag(level.g_effect["\xfa\x8c\xa9m!\xdbk\x15z\xe411R\xd1rXaOz"], tag, "\xec\xbfK|\au\xcd\xc2\x19<");

    if(soundexists("\x1a\x19\xcc\xe4%~\xc4\x03R\xb4oa4l\x11Z\vp\xae\xe6\x19\x9f\x05c\x12\xe0|\x14FqH\xfb+y\xc9\xe4$\xce\x01\x12Z\xf0}\x18T\x9fA\x8b")) {
      tag playSound("\x1a\x19\xcc\xe4%~\xc4\x03R\xb4oa4l\x11Z\vp\xae\xe6\x19\x9f\x05c\x12\xe0|\x14FqH\xfb+y\xc9\xe4$\xce\x01\x12Z\xf0}\x18T\x9fA\x8b");
      var_c65c72427f12968 scalevolume(0, 0);
      var_c65c72427f12968 playLoopSound("Yy\xcd\xc1\x88#&U\xda\f\xfe]^\x05t\xeet\x1b\xe1C\xe2\x96\xc7\xb6\xda\xfc\xbd/S\xbb\xb6\b\xc2a\x15=z{\xc9\xd9\x8f\x0fk\x8b\x97");
      var_c65c72427f12968 scalevolume(1, 0.25);
      var_c65c72427f12968 thread sfx_stop_water_barrel_stream(tag);
    }

    self.spewtags = utility::array_add(self.spewtags, tag);
    thread waterimpactlife(tag);
  }
}

function waterbarrelshoulddie(amount, attacker, type, objweapon) {
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

function waterimpactlife(spewtag) {
  utility::waittill_notify_or_timeout("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19", 5);

  if(isDefined(self)) {
    self.spewtags = arrayremove(self.spewtags, spewtag);
  }

  spewtag delete();
}

function water_barrel_death() {
  self notify("m\xd9S\xb0\xae%\xc1dt&\xf9,");

  if(isDefined(self)) {
    self hide();
  }

  playFX(level.g_effect["\x05\xd4\x14 \"a\r'\xbf\x8d\xa0\xdc\xf1\x9b\xc8\xcde\xa0"], self.origin);

  foreach(element in self.spewtags) {
    killfxontag(level.g_effect["\xfa\x8c\xa9m!\xdbk\x15z\xe411R\xd1rXaOz"], element, "\xec\xbfK|\au\xcd\xc2\x19<");
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

function sfx_stop_water_barrel_stream(tag) {
  wait 3.5;
  fadeoutduration = 0.25;
  tag playSound("\xe6S\xc0\xfc\x86\x10\x99\xf6\xff[\xd0\x87JVe|\xe6T\xc6\x9c\x04\xd7Wt}\x98\xc8\v\xe9\xc9[\x8en\xc3H}\x8a\x9d\x94\x7f\xff\xd8\b\x84\tL\xde");
  self scalevolume(0, fadeoutduration);
  wait 0.3;
  self stoploopsound("Yy\xcd\xc1\x88#&U\xda\f\xfe]^\x05t\xeet\x1b\xe1C\xe2\x96\xc7\xb6\xda\xfc\xbd/S\xbb\xb6\b\xc2a\x15=z{\xc9\xd9\x8f\x0fk\x8b\x97");
  self delete();
}