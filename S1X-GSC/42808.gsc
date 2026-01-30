/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42808.gsc
**************************************/

init() {
  level._effect["exo_knife_blood"] = loadfx("vfx/weaponimpact/flesh_impact_head_fatal_exit");
}

exo_knife_think() {
  thread exo_knife_throw_watch();
}

exo_knife_throw_watch() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 != "exoknife_mp" && var_2 != "exoknife_jug_mp") {
      continue;
    }
    var_0.manuallydetonatefunc = ::exo_knife_manually_detonate;
    var_0.flying = 1;
    var_0.weaponname = var_1;

    if(!isDefined(var_0.recall)) {
      var_0.recall = 0;
    }

    var_0.owner = self;
    thread exo_knife_enable_detonate(var_0);
    var_0 thread exo_knife_touch_watch();
    var_0 thread exo_knife_stuck_watch();
    var_0 thread exo_knife_recall_watch();
    var_0 thread exo_knife_emp_watch();
  }
}

exo_knife_emp_watch() {
  self endon("death");

  for(;;) {
    level waittill("emp_update");

    if(isDefined(level.empequipmentdisabled) && level.empequipmentdisabled && self.owner maps\mp\_utility::isempedbykillstreak()) {
      thread exo_knife_delete();
    }
  }
}

exo_knife_enable_detonate(var_0) {
  self endon("disconnect");

  if(!isDefined(self.exoknife_count)) {
    self.exoknife_count = 0;
  }

  if(!self.exoknife_count) {
    common_scripts\utility::_enabledetonate(var_0.weaponname, 1);
  }

  self.exoknife_count++;
  var_0 waittill("death");
  self.exoknife_count--;

  if(!self.exoknife_count) {
    common_scripts\utility::_enabledetonate(var_0.weaponname, 0);
  }
}

exo_knife_passed_target() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("missile_passed_target");
  exo_knife_restock();
}

exo_knife_touch_watch() {
  if(!isDefined(self.owner)) {
    return;
  }
  self endon("death");
  self.owner endon("disconnect");
  var_0 = spawn("trigger_radius", self.origin, 0, 15, 5);
  var_0 enablelinkto();
  var_0 linkto(self);
  var_0.knife = self;
  thread common_scripts\utility::delete_on_death(var_0);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 != self.owner) {
      continue;
    }
    if(var_1 getfractionmaxammo(self.weaponname) >= 1.0) {
      continue;
    }
    break;
  }

  exo_knife_restock();
}

exo_knife_restock() {
  self.owner setclientomnvar("damage_feedback", "throwingknife");
  self.owner setweaponammostock(self.weaponname, self.owner getweaponammostock(self.weaponname) + 1);
  exo_knife_delete();
}

exo_knife_stuck_watch() {
  self endon("death");

  for(;;) {
    self waittill("missile_stuck", var_0);
    var_1 = maps\mp\_riotshield::entisstucktoshield();
    self.flying = 0;
    self.recall = 0;

    if(isDefined(self.owner) && isDefined(var_0) && (isDefined(level.ishorde) && level.ishorde && var_0.model == "animal_dobernan" || maps\mp\_utility::isgameparticipant(var_0)) && !var_1) {
      if(isDefined(var_0.team) && isDefined(self.owner.team) && var_0.team != self.owner.team) {
        playimpactheadfatalfx(self.origin, self.origin - self.owner.origin);
      }

      var_0 maps\mp\_snd_common_mp::snd_message("exo_knife_player_impact");
      var_2 = getdvarfloat("exo_knife_return_delay", 0.5);
      self.owner thread exo_knife_recall(var_2);
      continue;
    }

    thread maps\mp\gametypes\_weapons::stickyhandlemovers(undefined, "exo_knife_recall");
  }
}

exo_knife_recall_stuck_watch() {
  self endon("death");

  for(;;) {
    self waittill("missile_stuck", var_0);

    if(isDefined(self.owner) && isDefined(var_0) && var_0 maps\mp\_utility::isjuggernaut()) {
      if(!level.teambased || isDefined(self.owner.team) && isDefined(var_0.team) && var_0.team != self.owner.team) {
        thread exo_knife_delete();
      }
    }
  }
}

exo_knife_recall(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("exo_knife_recall");

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }

  self notify("exo_knife_recall");
}

exo_knife_manually_detonate(var_0) {
  if(isDefined(var_0) && !var_0.recall) {
    exo_knife_recall();
  }
}

exo_knife_recall_watch() {
  self endon("death");

  if(!isDefined(self.owner)) {
    return;
  }
  self.owner endon("disconnect");
  self.owner endon("death");
  self.owner waittill("exo_knife_recall");
  var_0 = self.origin;
  var_1 = self.owner getEye();

  if(self.owner getstance() != "prone") {
    var_1 = var_1 - (0, 0, 20);
  }

  var_2 = getdvarfloat("exo_knife_speed", 1200.0);
  var_3 = distance(var_0, var_1);
  var_4 = var_3 / var_2;
  var_5 = self.owner getvelocity();
  var_1 = var_1 + var_5 * var_4;
  var_6 = var_1 - var_0;
  var_6 = vectornormalize(var_6);
  var_7 = 0;

  if(var_7 != 0) {
    var_0 = var_0 + var_6 * var_7;
  }

  var_8 = var_6 * var_2;
  var_9 = magicgrenademanual(self.weaponname, var_0, var_8, 30, self.owner, 1);
  var_9.owner = self.owner;
  var_9.recall = 1;
  var_9 missile_settargetent(self.owner);
  var_9 thread exo_knife_recall_stuck_watch();
  var_9 thread exo_knife_passed_target();
  exo_knife_delete();
}

exo_knife_clean_up_attractor(var_0, var_1, var_2) {
  common_scripts\utility::waittill_any_ents(var_1, "disconnect", var_1, "death", var_2, "death", var_2, "missile_stuck");
  missile_deleteattractor(var_0);
}

exo_knife_delete() {
  self delete();
}