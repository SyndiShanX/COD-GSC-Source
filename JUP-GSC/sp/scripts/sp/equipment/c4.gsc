/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\c4.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\damagefeedback;
#using scripts\sp\door;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace c4;

function precache(offhand) {
  level.offhands.c4 = spawnStruct();
  registeroffhandfirefunc(offhand, &c4firemain);
}

function c4firemain(grenade, weapon) {
  if(!isDefined(grenade)) {
    return;
  }

  grenade endon("death");
  grenade.owner = self;
  grenade setentityowner(self);
  grenade setotherent(self);
  grenade makeunusable();
  grenade.targetname = "offhand_car_grenade";
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade.throwtime = gettime();
  c4_addtoarray(self, grenade);
  thread c4_watchfordetonation();
  grenade thread minedamagemonitor();
  grenade thread c4_explodeonnotify();
  grenade waittill("missile_stuck");
  thread function_6e5ce23490c6fea6(grenade, weapon, &"EQUIPMENT/IMPROVISED_MINE_PICKUP");
  grenade setscriptablepartstate("effects", "plant", 0);
  grenade thread function_127a31c7d0c84559(256, "allies", 20);
}

function c4_watchfordetonation() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  self notify("watchForDetonation");
  self endon("watchForDetonation");
  childthread function_72907a80aa28034d();

  while(true) {
    self waittill("detonate");
    thread c4_detonateall();
  }
}

function function_72907a80aa28034d() {
  self endon("detonate");
  var_81a669da4deafdb8 = "use_pressed";
  detonatedelay = 0.5;

  while(true) {
    self waittill(var_81a669da4deafdb8);

    if(player_has_equipment("c4_sp")) {
      continue;
    }

    result = waittill_notify_or_timeout_return(var_81a669da4deafdb8, 1);

    if(result != var_81a669da4deafdb8) {
      continue;
    }

    wait detonatedelay;
    self notify("detonate");
  }
}

function c4_watchforaltdetonation() {
  self endon("death");
  self endon("c4_unset");
  level endon("game_ended");

  if(!getdvarint(@ "scr_altdetonationenabled", 0)) {
    return;
  }

  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");

  while(self useButtonPressed()) {
    waitframe();
  }

  buttontime = 0;

  while(true) {
    if(self useButtonPressed()) {
      buttontime = 0;

      while(self useButtonPressed()) {
        buttontime += 0.05;
        waitframe();
      }

      if(buttontime >= 0.5) {
        continue;
      }

      buttontime = 0;

      while(!self useButtonPressed() && buttontime < 0.25) {
        buttontime += 0.05;
        waitframe();
      }

      if(buttontime >= 0.25) {
        continue;
      }

      if(c4_validdetonationstate()) {
        thread c4_animdetonate();
      }
    }

    waitframe();
  }
}

function c4_animdetonate() {
  objweapon = makeweapon("c4_empty_sp");
  self giveandfireoffhand(objweapon);
  thread c4_animdetonatecleanup();
}

function c4_animdetonatecleanup() {
  self endon("death_or_disconnect");
  self notify("c4_animDetonateCleanup()");
  self endon("c4_animDetonateCleanup()");
  objweapon = makeweapon("c4_empty_sp");
  wait 1;

  if(self hasweapon(objweapon)) {
    self takeweapon(objweapon);
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
    foreach(c4 in self.c4s) {
      if(c4 c4_candetonate()) {
        c4 thread c4_detonate();
      }
    }
  }
}

function c4_detonate() {
  self endon("death");
  wait 0.1;
  thread c4_explode(self.owner);
}

function c4_explode(attacker) {
  self setentityowner(attacker);
  self clearscriptabledamageowner();
  self setscriptablepartstate("effects", "explode", 0);
  function_fe7bbb1bfcd13664();
  thread c4_delete(2.5);
}

function c4_destroy(attacker) {
  thread c4_delete(2.5);
  self setscriptablepartstate("effects", "destroy", 0);
}

function c4_delete(deletiondelay) {
  self notify("death");
  self setCanDamage(0);
  self makeunusable();
  self.exploding = 1;
  owner = self.owner;

  if(isDefined(owner)) {
    c4_removefromarray(owner, self, self getentitynumber());
    owner notify("c4_update", 0);
  }

  wait deletiondelay;

  if(isDefined(self)) {
    self delete();
  }
}

function function_fe7bbb1bfcd13664() {
  if(isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_c25c8afb5e774fc1)) {
    return;
  }

  interactivedoors = scripts\sp\door::get_all_interactive_doors();
  var_175138d237722678 = function_e31087776398ea53(self.origin, self.origin, 256, scripts\engine\trace::create_item_contents(), interactivedoors, "physicsquery_all");

  foreach(spherecast in var_175138d237722678) {
    door = spherecast["entity"];
    opener = spawnStruct();
    opener.origin = self.origin;
    door notify("breached");
    door scripts\sp\door::unlock_door(1);
    door scripts\sp\door::door_open_completely(opener, 0.3);
  }
}

function c4_explodeonnotify() {
  self endon("entitydeleted");
  level endon("game_ended");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);

  if(isDefined(attacker)) {
    thread c4_explode(attacker);
    return;
  }

  thread c4_explode(owner);
}

function c4_addtoarray(owner, grenade) {
  if(!isDefined(owner.c4s)) {
    owner.c4s = [];
  }

  entnum = grenade getentitynumber();
  owner.c4s[entnum] = grenade;

  if(isPlayer(owner)) {
    owner function_bcc86382f02470e6(1);
  }

  thread c4_removefromarrayondeath(owner, grenade, entnum);
}

function c4_removefromarray(owner, grenade, entnum) {
  if(isDefined(grenade)) {
    grenade notify("c4_removeFromArray");
  }

  if(isDefined(owner) && isDefined(owner.c4s) && isPlayer(owner)) {
    owner.c4s[entnum] = undefined;

    foreach(c4 in owner.c4s) {
      if(isDefined(c4)) {
        return;
      }
    }

    owner function_bcc86382f02470e6(0);
  }
}

function c4_removefromarrayondeath(owner, grenade, entnum) {
  grenade endon("c4_removeFromArray");
  owner endon("disconnect");
  grenade waittill("death");
  thread c4_removefromarray(owner, grenade, entnum);
}

function c4nodetonatorfiremain(c4) {
  if(!isDefined(c4)) {
    return;
  }

  level.player endon("death");
  c4 waittill("missile_stuck", stuckto);
  c4.targetname = "offhand_c4_no_detonator";
  c4.owner = self;
  c4 setscriptablepartstate("effects", "plant", 0);
  c4 makeunusable();
  c4.interact = c4 c4createcursor();
  result = waittill_any_ents_return(c4, "detonate", c4.interact, "trigger", c4.interact, "entitydeleted");

  if(isDefined(c4.interact)) {
    c4.interact delete();
  }

  if(result == "detonate") {
    c4 thread c4detonation();
    return;
  }

  if(result == "trigger") {
    c4 delete();
    thread play_sound_in_space("weap_pickup", level.player.origin);

    if(level.player player_has_weapon("c4_no_detonator")) {
      ammostock = level.player getweaponammostock("c4_no_detonator");
      level.player setweaponammoclip("c4_no_detonator", ammostock + 1);
      return;
    }

    level.player give_offhand("c4_no_detonator");
    level.player setweaponammoclip("c4_no_detonator", 1);
  }
}

function c4detonation() {
  self setscriptablepartstate("effects", "explode", 0);
}

function c4createcursor() {
  interact = spawn_tag_origin();
  interact linkTo(self);
  interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 10), "^2Pickup", 35, 250, 100, 0, undefined, undefined, undefined, "duration_short", undefined, undefined, 8);
  return interact;
}

function minedamagemonitor() {
  self endon("mine_selfdestruct");
  self endon("entitydeleted");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;
  hits = 1;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker) && !isagent(attacker)) {
      continue;
    }

    if(isDefined(objweapon) && objweapon.basename == "flash") {
      continue;
    }

    if(isPlayer(attacker)) {
      attacker scripts\sp\damagefeedback::updatehitmarker("standard", 1, 0);
    }

    incominghits = 1;
    hits -= incominghits;

    if(hits <= 0) {
      break;
    }
  }

  self notify("mine_destroyed");

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(idflags) && isDefined(8) && idflags & 8) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(idflags) && isDefined(256) && idflags & 256) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(attacker)) {
    self.damagedby = attacker;
  }

  self notify("detonateExplosive", attacker);
}

function function_f375135dd6b57a71(c4, var_ff882f75755f7367) {
  self endon("death");
  self endon("detonate");

  while(true) {
    c4 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 5), &"EQUIPMENT/IMPROVISED_MINE_PICKUP", 55, 100, 70, 0);
    c4 childthread function_bb7d0fd0262d852d(&"EQUIPMENT/IMPROVISED_MINE_PICKUP", var_ff882f75755f7367);
    c4 waittill("trigger");
    pickedup = function_e2c7f0ed80637008(var_ff882f75755f7367);

    if(!pickedup) {
      continue;
    }

    c4 delete();
    return;
  }
}