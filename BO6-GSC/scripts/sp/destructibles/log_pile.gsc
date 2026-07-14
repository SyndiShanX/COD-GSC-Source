/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\log_pile.gsc
*************************************************/

#using scripts\engine\utility;
#namespace log_pile;

function function_4d6af4877a912d0c() {
  piles = getEntArray("\xab\x0fh\xb7\x9c\x1b\xbf\x9f\x14\xbe\x18\xb9", #targetname);

  if(piles.size <= 0) {
    return;
  }

  level.g_effect["c\xdeg\xf5\aZ6\x95\xafi\xb5\xe0\x16\xc6\x8e"] = loadfxasset("\xa7\x19\xe5;\x01\xd0J\xf2\xde\xbc/\xf7 \xd2w\xb9\x8c L,Zw\x80\xd9&h\xfd\x19\xe5\xf4\xafw*\x9c\xbf");

  for(i = 0; i < piles.size; i++) {
    piles[i] setCanDamage(1);
    piles[i].spewtags = [];
    piles[i] thread log_pile();
  }
}

function log_pile() {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  while(true) {
    self waittill("\fU`\xc0y\x95", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon);

    if(!isDefined(type)) {
      continue;
    }

    if(utility::ismeleedamage(type)) {
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
    playFXOnTag(level.g_effect["c\xdeg\xf5\aZ6\x95\xafi\xb5\xe0\x16\xc6\x8e"], tag, "\xec\xbfK|\au\xcd\xc2\x19<");
    self.spewtags = utility::array_add(self.spewtags, tag);
    thread function_5bd972ecd11538fd(tag);
  }
}

function function_5bd972ecd11538fd(spewtag) {
  utility::waittill_notify_or_timeout("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19", 5);

  if(isDefined(self)) {
    self.spewtags = arrayremove(self.spewtags, spewtag);
  }

  spewtag delete();
}