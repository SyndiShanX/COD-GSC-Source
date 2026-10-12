/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\destructables.gsc
***********************************************/

#namespace destructables;

function init() {
  ents = getEntArray("destructable", "targetname");

  if(getDvar(@ "scr_destructables") == "0") {
    for(i = 0; i < ents.size; i++) {
      ents[i] delete();
    }

    return;
  }

  for(i = 0; i < ents.size; i++) {
    ents[i] thread destructable_think();
  }
}

function destructable_think() {
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
      blockarea(areas[i]);
    }
  }

  if(isDefined(self.script_fxid)) {
    self.fx = loadfx(self.script_fxid);
  }

  dmg = 0;
  self setCanDamage(1);

  while(true) {
    self waittill("damage", amount, other);

    if(amount >= threshold) {
      dmg += amount;

      if(dmg >= accumulate) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

function destructable_destruct() {
  ent = self;

  if(isDefined(self.script_destructable_area)) {
    areas = strtok(self.script_destructable_area, " ");

    for(i = 0; i < areas.size; i++) {
      unblockarea(areas[i]);
    }
  }

  if(isDefined(ent.fx)) {
    playFX(ent.fx, ent.origin + (0, 0, 6));
  }

  ent delete();
}

function blockarea(area) {}

function blockentsinarea(ents, area) {}

function unblockarea(area) {}

function unblockentsinarea(ents, area) {}