/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\c4.gsc
***********************************************/

function precache(var0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var0, &c4firemain);
}

function c4firemain(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var0 endon("death");
  var0.owner = self;
  var0.throwtime = gettime();
  c4_addtoarray(self, var0);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();
  thread minedamagemonitor();
  thread c4_explodeonnotify();
  var0 waittill("missile_stuck");
  var0 setotherent(self);
  var0 setnodeploy(1);
  var0 setscriptablepartstate("effects", "plant", 0);
}

function c4_watchfordetonation() {
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

function c4_watchforaltdetonation() {
  self endon("death");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");

  while(self useButtonPressed()) {
    waitframe();
  }

  var0 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var0 = 0;

      while(self useButtonPressed()) {
        var0 += 0.05;
        waitframe();
      }

      if(var0 >= 0.5) {
        continue;
      }

      var0 = 0;

      while(!self useButtonPressed() && var0 < 0.25) {
        var0 += 0.05;
        waitframe();
      }

      if(var0 >= 0.25) {
        continue;
      }

      if(c4_validdetonationstate()) {
        thread c4_detonateall();
      }
    }

    waitframe();
  }
}

function c4_validdetonationstate() {
  if(!isalive(self)) {
    return false;
  }

  if(!isDefined(self.c4s) || self.c4s.size <= 0) {
    return false;
  }

  return true;
}

function c4_candetonate() {
  return (gettime() - self.throwtime) / 1000 > 0.3;
}

function c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(var1 in self.c4s) {
      if(c4_candetonate(var1)) {
        thread c4_detonate();
      }
    }

    return;
  }
}

function c4_detonate() {
  self endon("death");
  wait 0.1;
  thread c4_explode(self.owner);
}

function c4_explode(var0) {
  thread c4_delete(5);
  self setentityowner(var0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("effects", "explode", 0);
}

function c4_destroy(var0) {
  thread c4_delete(5);
  self setscriptablepartstate("effects", "destroy", 0);
}

function c4_delete(var0) {
  self notify("death");
  self setCanDamage(0);
  self makeunusable();
  self.exploding = 1;
  var1 = self.owner;

  if(isDefined(var1)) {
    c4_removefromarray(var1, self, self getentitynumber());
    var1 notify("c4_update", 0);
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  wait var0;
  self delete();
}

function c4_explodeonnotify() {
  self endon("death");
  level endon("game_ended");
  var0 = self.owner;
  self waittill("detonateExplosive", var1);

  if(isDefined(var1)) {
    thread c4_explode(var1);
    return;
  }

  thread c4_explode(var0);
}

function c4_addtoarray(var0, var1) {
  if(!isDefined(var0.c4s)) {
    var0.c4s = [];
  }

  var2 = var1 getentitynumber();
  var0.c4s[var2] = var1;
  thread c4_removefromarrayondeath(var0, var1, var2);
}

function c4_removefromarray(var0, var1, var2) {
  if(isDefined(var1)) {
    var1 notify("c4_removeFromArray");
  }

  if(isDefined(var0) && isDefined(var0.c4s)) {
    var0.c4s[var2] = undefined;
    return;
  }
}

function c4_removefromarrayondeath(var0, var1, var2) {
  var1 endon("c4_removeFromArray");
  var0 endon("disconnect");
  var1 waittill("death");
  thread c4_removefromarray(var0, var1, var2);
}

function c4nodetonatorfiremain(var0) {
  if(!isDefined(var0)) {
    return;
  }

  level.player endon("death");
  var0 waittill("missile_stuck", var1);
  var0.targetname = "offhand_c4_no_detonator";
  var0.owner = self;
  var0 setscriptablepartstate("effects", "plant", 0);
  var0 makeunusable();
  var0.interact = c4createcursor(var0);
  var2 = scripts\engine\utility::waittill_any_ents_return(var0, "detonate", var0.interact, "trigger", var0.interact, "entitydeleted");

  if(isDefined(var0.interact)) {
    var0.interact delete();
  }

  if(var2 == "detonate") {
    thread c4detonation();
    return;
  }

  if(var2 == "trigger") {
    var0 delete();
    thread scripts\engine\utility::play_sound_in_space("weap_pickup", level.player.origin);

    if(level.player scripts\engine\sp\utility::player_has_weapon("c4_no_detonator")) {
      var3 = level.player getweaponammostock("c4_no_detonator");
      level.player setweaponammoclip("c4_no_detonator", var3 + 1);
      return;
    }

    level.player scripts\engine\sp\utility::give_offhand("c4_no_detonator");
    level.player setweaponammoclip("c4_no_detonator", 1);
    return;
  }
}

function c4detonation() {
  self setscriptablepartstate("effects", "explode", 0);
}

function c4createcursor() {
  var0 = scripts\engine\utility::spawn_tag_origin();
  var0 linkTo(self);
  var0 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 10), "^2Pickup", 35, 250, 100, 0, undefined, undefined, undefined, "duration_short", undefined, undefined, 8);
  return var0;
}

function minegettwohitthreshold() {
  return 80;
}

function minedamagemonitor() {
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var0 = undefined;
  var1 = 1;

  for(;;) {
    self waittill("damage", var2, var0, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);

    if(!isPlayer(var0) && !isagent(var0)) {
      continue;
    }

    var15 = 1;
    var1 -= var15;

    if(var1 <= 0) {
      break;
    }
  }

  self notify("mine_destroyed");

  if(isDefined(var5) && (issubstr(var5, "MOD_GRENADE") || issubstr(var5, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var9) && var9 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var9) && var9 &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(var0)) {
    self.damagedby = var0;
  }

  self notify("detonateExplosive", var0);
}

function minedeletetrigger(var0) {
  scripts\engine\utility::waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function mineselfdestruct() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self notify("mine_selfdestruct");
  self notify("detonateExplosive");
}

function mineexplodeonnotify() {
  self endon("death");
  self waittill("detonateExplosive", var0);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = self.owner;
  }

  self notify("explode");
  waitframe();

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  self hide();
  wait 0.2;
  self delete();
}