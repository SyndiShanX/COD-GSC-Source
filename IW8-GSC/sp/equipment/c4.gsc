/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\c4.gsc
***********************************************/

precache(var_0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, ::c4firemain);
}

c4firemain(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  var_0.owner = self;
  var_0.throwtime = gettime();
  c4_addtoarray(self, var_0);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();
  var_0 thread minedamagemonitor();
  var_0 thread c4_explodeonnotify();
  var_0 waittill("missile_stuck");
  var_0 setotherent(self);
  var_0 setnodeploy(1);
  var_0 setscriptablepartstate("effects", "plant", 0);
}

c4_watchfordetonation() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");

  for(;;) {
    self waittill("detonate");
    thread c4_detonateall();
  }
}

c4_watchforaltdetonation() {
  self endon("death");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");

  while(self useButtonPressed())
    waitframe();

  var_0 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var_0 = 0;

      while(self useButtonPressed()) {
        var_0 = var_0 + 0.05;
        waitframe();
      }

      if(var_0 >= 0.5) {
        continue;
      }
      var_0 = 0;

      while(!self useButtonPressed() && var_0 < 0.25) {
        var_0 = var_0 + 0.05;
        waitframe();
      }

      if(var_0 >= 0.25) {
        continue;
      }
      if(c4_validdetonationstate())
        thread c4_detonateall();
    }

    waitframe();
  }
}

c4_validdetonationstate() {
  if(!isalive(self))
    return 0;

  if(!isDefined(self.c4s) || self.c4s.size <= 0)
    return 0;

  return 1;
}

c4_candetonate() {
  return (gettime() - self.throwtime) / 1000 > 0.3;
}

c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(var_1 in self.c4s) {
      if(var_1 c4_candetonate())
        var_1 thread c4_detonate();
    }
  }
}

c4_detonate() {
  self endon("death");
  wait 0.1;
  thread c4_explode(self.owner);
}

c4_explode(var_0) {
  thread c4_delete(5);
  self setentityowner(var_0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("effects", "explode", 0);
}

c4_destroy(var_0) {
  thread c4_delete(5);
  self setscriptablepartstate("effects", "destroy", 0);
}

c4_delete(var_0) {
  self notify("death");
  self setCanDamage(0);
  self makeunusable();
  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(var_1)) {
    c4_removefromarray(var_1, self, self getentitynumber());
    var_1 notify("c4_update", 0);
  }

  if(isDefined(self.useobj))
    self.useobj delete();

  wait(var_0);
  self delete();
}

c4_explodeonnotify() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  self waittill("detonateExplosive", var_1);

  if(isDefined(var_1))
    thread c4_explode(var_1);
  else
    thread c4_explode(var_0);
}

c4_addtoarray(var_0, var_1) {
  if(!isDefined(var_0.c4s))
    var_0.c4s = [];

  var_2 = var_1 getentitynumber();
  var_0.c4s[var_2] = var_1;
  thread c4_removefromarrayondeath(var_0, var_1, var_2);
}

c4_removefromarray(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_1 notify("c4_removeFromArray");

  if(isDefined(var_0) && isDefined(var_0.c4s))
    var_0.c4s[var_2] = undefined;
}

c4_removefromarrayondeath(var_0, var_1, var_2) {
  var_1 endon("c4_removeFromArray");
  var_0 endon("disconnect");
  var_1 waittill("death");
  thread c4_removefromarray(var_0, var_1, var_2);
}

c4nodetonatorfiremain(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level.player endon("death");
  var_0 waittill("missile_stuck", var_1);
  var_0.targetname = "offhand_c4_no_detonator";
  var_0.owner = self;
  var_0 setscriptablepartstate("effects", "plant", 0);
  var_0 makeunusable();
  var_0.interact = var_0 c4createcursor();
  var_2 = scripts\engine\utility::waittill_any_ents_return(var_0, "detonate", var_0.interact, "trigger", var_0.interact, "entitydeleted");

  if(isDefined(var_0.interact))
    var_0.interact delete();

  if(var_2 == "detonate")
    var_0 thread c4detonation();
  else if(var_2 == "trigger") {
    var_0 delete();
    thread scripts\engine\utility::play_sound_in_space("weap_pickup", level.player.origin);

    if(level.player scripts\engine\sp\utility::player_has_weapon("c4_no_detonator")) {
      var_3 = level.player getweaponammostock("c4_no_detonator");
      level.player setweaponammoclip("c4_no_detonator", var_3 + 1);
    } else {
      level.player scripts\engine\sp\utility::give_offhand("c4_no_detonator");
      level.player setweaponammoclip("c4_no_detonator", 1);
    }
  }
}

c4detonation() {
  self setscriptablepartstate("effects", "explode", 0);
}

c4createcursor() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self);
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 10), "^2Pickup", 35, 250, 100, 0, undefined, undefined, undefined, "duration_short", undefined, undefined, 8);
  return var_0;
}

minegettwohitthreshold() {
  return 80;
}

minedamagemonitor() {
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;
  var_1 = 1;

  for(;;) {
    self waittill("damage", var_2, var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(!isPlayer(var_0) && !isagent(var_0)) {
      continue;
    }
    var_15 = 1;
    var_1 = var_1 - var_15;

    if(var_1 <= 0) {
      break;
    }
  }

  self notify("mine_destroyed");

  if(isDefined(var_5) && (issubstr(var_5, "MOD_GRENADE") || issubstr(var_5, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isDefined(var_9) && var_9 &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  if(isDefined(var_9) && var_9 &level.idflags_ricochet)
    self.wasdamagedfrombulletricochet = 1;

  self.wasdamaged = 1;

  if(isDefined(var_0))
    self.damagedby = var_0;

  self notify("detonateExplosive", var_0);
}

minedeletetrigger(var_0) {
  scripts\engine\utility::waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(var_0))
    var_0 delete();
}

mineselfdestruct() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self notify("mine_selfdestruct");
  self notify("detonateExplosive");
}

mineexplodeonnotify() {
  self endon("death");
  self waittill("detonateExplosive", var_0);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = self.owner;

  self notify("explode");
  waitframe();

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();
  wait 0.2;
  self delete();
}