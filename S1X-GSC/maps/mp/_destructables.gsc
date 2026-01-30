/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_destructables.gsc
***************************************************/

init() {
  ents = getEntArray("destructable", "targetname");

  if(getdvar("scr_destructables") == "0") {
    for(i = 0; i < ents.size; i++) {
      ents[i] delete();
    }
  } else {
    for(i = 0; i < ents.size; i++) {
      ents[i] thread destructable_think();
    }
  }
}

destructable_think() {
  accumulate = 40;
  threshold = 0;

  if(isDefined(self.script_accumulate)) {
    accumulate = self.script_accumulate;
  }
  if(isDefined(self.script_threshold)) {
    threshold = self.script_threshold;
  }

  if(isDefined(self.script_destructable_area)) {
    areas = strtok(self.script_destructable_area, " ");
    for(i = 0; i < areas.size; i++) {
      self blockArea(areas[i]);
    }
  }

  if(isDefined(self.script_fxid)) {
    self.fx = loadfx(self.script_fxid);
  }

  dmg = 0;

  self setCanDamage(true);
  while(1) {
    self waittill("damage", amount, other);
    if(amount >= threshold) {
      dmg += amount;
      if(dmg >= accumulate) {
        self thread destructable_destruct();
        return;
      }
    }
  }
}

destructable_destruct() {
  ent = self;
  if(isDefined(self.script_destructable_area)) {
    areas = strtok(self.script_destructable_area, " ");
    for(i = 0; i < areas.size; i++) {
      self unblockArea(areas[i]);
    }
  }
  if(isDefined(ent.fx)) {
    playFX(ent.fx, ent.origin + (0, 0, 6));
  }
  ent delete();
}

blockArea(area) {}
blockEntsInArea(ents, area) {}
unblockArea(area) {}
unblockEntsInArea(ents, area) {}