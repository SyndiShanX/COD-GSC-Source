/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\destructables.gsc
***********************************************/

init() {
  ents = getEntArray("destructable", "targetname");

  if(getDvar("dvar_022975EF58F3A25E") == "0") {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < ents.size; _id_AC0E594AC96AA3A8++)
      ents[_id_AC0E594AC96AA3A8] delete();
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < ents.size; _id_AC0E594AC96AA3A8++)
      ents[_id_AC0E594AC96AA3A8] thread destructable_think();
  }
}

destructable_think() {
  accumulate = 40;
  threshold = 0;

  if(isDefined(self.script_accumulate))
    accumulate = self.script_accumulate;

  if(isDefined(self.script_threshold))
    threshold = self.script_threshold;

  if(isDefined(self.script_destructable_area)) {
    _id_D09AECDB0D855501 = strtok(self.script_destructable_area, " ");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D09AECDB0D855501.size; _id_AC0E594AC96AA3A8++)
      blockarea(_id_D09AECDB0D855501[_id_AC0E594AC96AA3A8]);
  }

  if(isDefined(self.script_fxid))
    self.fx = loadfx(self.script_fxid);

  dmg = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", amount, other);

    if(amount >= threshold) {
      dmg = dmg + amount;

      if(dmg >= accumulate) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

destructable_destruct() {
  ent = self;

  if(isDefined(self.script_destructable_area)) {
    _id_D09AECDB0D855501 = strtok(self.script_destructable_area, " ");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D09AECDB0D855501.size; _id_AC0E594AC96AA3A8++)
      unblockarea(_id_D09AECDB0D855501[_id_AC0E594AC96AA3A8]);
  }

  if(isDefined(ent.fx))
    playFX(ent.fx, ent.origin + (0, 0, 6));

  ent delete();
}

blockarea(area) {}

blockentsinarea(ents, area) {}

unblockarea(area) {}

unblockentsinarea(ents, area) {}