/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml_dogattacks.gsc
*****************************************************/

#using_animtree("dog");

meleestrugglevsai_first_attack(var_0) {
  self.safetochangescript = 0;
  self animmode("zonly_physics");
  self.pushable = 0;
  self clearpitchorient();
  self.meleekilltarget = 1;
  self.originaltarget = self.enemy;
  self.enemy.battlechatter = 0;
  self.enemy.ignoreall = 1;
  self.enemy clearenemy();
  self.enemy.diequietly = 1;
  self.originaltarget.attack_dir = "F";
  var_1 = vectortoangles(self.origin - self.enemy.origin);
  var_1 = (0, var_1[1], 0);
  var_2 = [];
  var_2[0] = % body;
  var_2[1] = % iw6_dog_kill_front_nml;
  var_3 = 1;

  if(isDefined(self.controlling_dog) && self.controlling_dog) {
    thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_intro_plr");
  }
  else {
    thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_front_npc");
  }

  return domeleevsai(var_2, var_3, var_1);
}

meleestrugglevsai_supershort(var_0) {
  self.safetochangescript = 0;
  self animmode("zonly_physics");
  self.pushable = 0;
  self clearpitchorient();
  self.meleekilltarget = !isDefined(self.enemy.magic_bullet_shield) && (isDefined(self.enemy.a.doinglongdeath) || isDefined(self.meleealwayswin) || randomint(100) > 50);
  self.originaltarget = self.enemy;
  self.enemy.battlechatter = 0;
  self.enemy.ignoreall = 1;
  self.enemy clearenemy();
  self.enemy.diequietly = 1;
  var_1 = 0;

  if(isDefined(self.enemy.use_old_dog_attack)) {
    var_1 = 1;
  }

  return meleestrugglevsai_short(var_0, var_1);
}

domeleevsdog(var_0, var_1, var_2) {
  self endon("killanimscript");
  self endon("death");
  self endon("end_melee_struggle");
  self endon("end_melee_all");

  if(!isDefined(self.syncedmeleetarget)) {
    return;
  }
  self stopsounds();

  if(isDefined(var_2)) {
    [[var_2]]();
  }

  self orientmode("face angle", var_1);
  self animmode("gravity");
  self.olddontattackme = self.dontattackme;
  self.dontattackme = 1;
  self.battlechatter = 0;
  self.a.pose = "stand";
  self.a.special = "none";

  if(animscripts\utility::usingsidearm()) {
    animscripts\shared::placeweaponon(self.primaryweapon, "right");
  }

  self.ragdoll_immediate = 1;
  self.meleeseq = 0;
  thread meleestrugglevsdog_interruptedcheck();
  self clearanim(var_0[0], 0.1);
  self setflaggedanimrestart("aianim", var_0[1], 1, 0.1, 1);
  thread animscripts\shared::donotetracks("aianim");
  wait 0.15;
  self.syncedmeleetarget linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  thread meleestrugglevsdog_collision();
  self waittillmatch("aianim", "end");

  if(!isDefined(self.magic_bullet_shield)) {
    self.forceragdollimmediate = 1;
    self.a.nodeath = 1;
    animscripts\shared::dropallaiweapons();
    self kill(self.dog_attacking_me.origin, self.dog_attacking_me);
  }

  meleestrugglevsdog_end();
}

meleestruggle_istraverse() {
  var_0 = self getdogattackbeginnode();
  return isDefined(var_0);
}

meleestrugglevsai_traverse(var_0) {
  self.safetochangescript = 0;
  self animmode("zonly_physics");
  self.pushable = 0;
  self clearpitchorient();
  self.meleekilltarget = !isDefined(self.enemy.magic_bullet_shield) && (isDefined(self.enemy.a.doinglongdeath) || isDefined(self.meleealwayswin) || randomint(100) > 50);
  self.originaltarget = self.enemy;
  self.enemy.battlechatter = 0;
  var_1 = vectortoangles(self.origin - self.enemy.origin);
  var_1 = (0, var_1[1], 0);
  var_2 = [];
  var_2[0] = % body;
  var_2[1] = % iw6_dog_kill_front_long_1;
  var_3 = 1;
  return domeleevsai(var_2, var_3, var_1, ::meleestrugglevsdog_traverse);
}

meleestrugglevsai_short(var_0, var_1) {
  if(meleestruggle_istraverse()) {
    return meleestrugglevsai_traverse(var_0);
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self.safetochangescript = 0;
  self animmode("zonly_physics");
  self.pushable = 0;
  self clearpitchorient();
  self.meleekilltarget = !isDefined(self.enemy.magic_bullet_shield) && (isDefined(self.enemy.a.doinglongdeath) || isDefined(self.meleealwayswin) || randomint(100) > 50);
  self.originaltarget = self.enemy;
  self.enemy.battlechatter = 0;
  self.enemy.ignoreall = 1;
  self.enemy clearenemy();
  self.enemy.diequietly = 1;
  var_2 = vectortoangles(self.origin - self.enemy.origin);
  var_2 = (0, var_2[1], 0);

  if(var_1) {
    self.enemy.use_old_dog_attack = 1;
    var_3 = [];
    var_3[0] = % body;
    var_3[1] = % iw6_dog_kill_front_quick_1;
    var_4 = 1;
    thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short");
  } else {
    var_3 = [];
    var_3[0] = % body;
    var_3[1] = % iw6_dog_kill_front_long_1;
    var_4 = 1;

    switch (var_0) {
      case "R":
        self.enemy.use_old_dog_attack = 1;
        var_3 = [];
        var_3[0] = % body;
        var_3[1] = % iw6_dog_kill_right_quick_1;
        var_4 = 1;
        thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short");
        break;
      case "L":
        self.enemy.use_old_dog_attack = 1;
        var_3 = [];
        var_3[0] = % body;
        var_3[1] = % iw6_dog_kill_left_quick_1;
        var_4 = 1;
        thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short");
        break;
      case "B":
        var_3 = [];
        var_3[0] = % body;
        var_3[1] = % iw6_dog_kill_back_quick_1;
        var_4 = 1;
        var_2 = var_2 - (0, 180, 0);

        if(isDefined(self.controlling_dog) && self.controlling_dog) {
          thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_quick_back_plr");
        }
        else {
          thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_quick_back_npc");
        }

        break;
      default:
        if(isDefined(self.controlling_dog) && self.controlling_dog) {
          thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_front_plr");
        }
        else {
          thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_front_npc");
        }
    }
  }

  return domeleevsai(var_3, var_4, var_2);
}

domeleevsai(var_0, var_1, var_2, var_3) {
  self notify("stop_pant");
  self setCanDamage(0);
  self clearanim(var_0[0], 0.1);
  self animrelative("meleeanim", self.enemy.origin, var_2, var_0[1]);
  self.enemy.fndogmeleevictim = var_3;

  if(!animhasnotetrack(var_0[1], "ai_attack_start")) {
    handlestartaipart("ai_attack_start");
  }

  animscripts\shared::donotetracks("meleeanim", ::handlestartaipart);
  self setCanDamage(1);
  self animmode("zonly_physics");

  for(var_4 = 1; var_4 < var_1; var_4++) {
    if(isDefined(level._effect["dog_bite"]) && isDefined(level._effect["dog_bite"][var_4]) && isDefined(self.enemy)) {
      playFXOnTag(level._effect["dog_bite"][var_4], self.enemy, "TAG_EYE");
    }

    self clearanim(var_0[var_4], 0);

    if(!animscripts\dog\dog_combat::insyncmeleewithtarget()) {
      break;
    }

    if(!self.meleekilltarget && var_4 + 1 == var_1) {
      self.health = 1;
    }

    self setflaggedanimrestart("meleeanim", var_0[var_4 + 1], 1, 0, 1);
    animscripts\shared::donotetracks("meleeanim");
  }

  self unlink();

  if(!self.meleekilltarget) {
    if(!isDefined(self.magic_bullet_shield)) {
      self kill();
    }
  } else {
    self.pushable = 1;
    self.safetochangescript = 1;
    self.flashbangimmunity = 0;
  }

  thread ragdoll_corpses();
  return 1;
}

handlestartaipart(var_0) {
  if(var_0 != "ai_attack_start") {
    handlevxnotetrack(var_0);
    return undefined;
  }

  if(!isDefined(self.enemy)) {
    return 1;
  }

  if(self.enemy != self.originaltarget) {
    return 1;
  }

  if(isDefined(self.enemy.syncedmeleetarget)) {
    return 1;
  }

  self.flashbangimmunity = 1;
  self.enemy.syncedmeleetarget = self;

  if(isDefined(self.enemy.fndogmeleevictim)) {
    self.enemy animcustom(self.enemy.fndogmeleevictim);
  }
  else {
    self.enemy animcustom(::meleestrugglevsdog_short);
  }
}

handlevxnotetrack(var_0) {
  if(common_scripts\utility::string_starts_with(var_0, "vfx")) {
    if(isDefined(level._effect[var_0])) {
      playFXOnTag(common_scripts\utility::getfx(var_0), self, "TAG_MOUTH_FX");
    }
  } else if(common_scripts\utility::string_starts_with(var_0, "screen_blood")) {
    if(isDefined(self.controlling_dog)) {
      var_1 = "bottom";

      if(issubstr(var_0, "right")) {
        var_1 = "right";
      }
      else if(issubstr(var_0, "left")) {
        var_1 = "left";
      }

      self notify("screen_blood", var_1);
    }
  }
}

#using_animtree("generic_human");

meleestrugglevsdog_short() {
  self endon("killanimscript");
  self endon("death");
  self endon("end_melee_struggle");
  self endon("end_melee_all");

  if(!isDefined(self.syncedmeleetarget)) {
    return;
  }
  self stopsounds();
  var_0 = vectortoangles(self.syncedmeleetarget.origin - self.origin);
  var_0 = var_0[1];

  if(isDefined(self.use_old_dog_attack) && self.use_old_dog_attack) {
    var_1 = [];
    var_1[0] = % body;
    var_1[1] = % iw6_dog_kill_front_quick_guy_1;
    var_2 = 1;
    maps\_utility::gun_remove();
  } else {
    var_1 = [];
    var_1[0] = % body;
    var_1[1] = % iw6_dog_kill_front_long_guy_1;
    var_2 = 1;

    switch (self.dog_attack_dir) {
      case "R":
        var_3 = [];
        var_1[0] = % body;
        var_1[1] = % iw6_dog_kill_right_quick_guy_1;
        var_2 = 1;
        var_0 = vectortoangles(self.syncedmeleetarget.origin - self.origin);
        var_0 = var_0[1] + 90;

        if(isDefined(self.syncedmeleetarget.controlling_dog)) {
          thread animscripts\face::saygenericdialogue("dogdeathshortplr");
        }
        else {
          thread animscripts\face::saygenericdialogue("dogdeathshort");
        }

        break;
      case "L":
        var_3 = [];
        var_1[0] = % body;
        var_1[1] = % iw6_dog_kill_left_quick_guy_1;
        var_2 = 1;
        var_0 = vectortoangles(self.syncedmeleetarget.origin - self.origin);
        var_0 = var_0[1] - 90;

        if(isDefined(self.syncedmeleetarget.controlling_dog)) {
          thread animscripts\face::saygenericdialogue("dogdeathshortplr");
        }
        else {
          thread animscripts\face::saygenericdialogue("dogdeathshort");
        }

        break;
      case "B":
        var_3 = [];
        var_1[0] = % body;
        var_1[1] = % iw6_dog_kill_back_quick_guy_1;
        var_2 = 1;
        var_0 = vectortoangles(self.syncedmeleetarget.origin - self.origin);
        var_0 = var_0[1] - 180;

        if(isDefined(self.syncedmeleetarget.controlling_dog)) {
          thread animscripts\face::saygenericdialogue("dogdeathshortplr");
        }
        else {
          thread animscripts\face::saygenericdialogue("dogdeathshort");
        }

        break;
      default:
        if(isDefined(self.syncedmeleetarget.controlling_dog)) {
          thread animscripts\face::saygenericdialogue("dogdeathlongplr");
        }
        else {
          thread animscripts\face::saygenericdialogue("dogdeathlong");
        }
    }
  }

  self orientmode("face angle", var_0);
  self animmode("gravity");
  self.olddontattackme = self.dontattackme;
  self.dontattackme = 1;
  self.battlechatter = 0;
  self.a.pose = "stand";
  self.a.special = "none";

  if(animscripts\utility::usingsidearm()) {
    animscripts\shared::placeweaponon(self.primaryweapon, "right");
  }

  self.ragdoll_immediate = 1;
  self.meleeseq = 0;
  thread meleestrugglevsdog_interruptedcheck();
  self clearanim(var_1[0], 0.1);
  self setflaggedanimrestart("aianim", var_1[1], 1, 0.1, 1);
  thread animscripts\shared::donotetracks("aianim");
  wait 0.15;
  self.syncedmeleetarget linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  thread meleestrugglevsdog_collision();
  self waittillmatch("aianim", "end");

  if(!isDefined(self.magic_bullet_shield)) {
    self.forceragdollimmediate = 1;
    self.a.nodeath = 1;
    animscripts\shared::dropallaiweapons();
    self kill();
  }

  meleestrugglevsdog_end();
}

meleestrugglevsdog_traverse() {
  if(!isDefined(self.syncedmeleetarget)) {
    return;
  }
  var_0 = vectortoangles(self.syncedmeleetarget.origin - self.origin);
  var_1 = var_0[1];
  var_2 = [];
  var_2[0] = % body;
  var_2[1] = % iw6_dog_kill_front_long_guy_1;
  domeleevsdog(var_2, var_1);
}

meleestrugglevsdog_interruptedcheck() {
  self endon("killanimscript");
  self endon("death");
  self endon("end_melee_all");
  var_0 = [];
  var_0[1] = % ai_attacked_german_shepherd_02_getup_a;
  var_0[2] = % ai_attacked_german_shepherd_02_getup_a;

  if(self.syncedmeleetarget.meleekilltarget) {
    var_0[4] = % ai_attacked_german_shepherd_04_getup_a;
  }

  for(;;) {
    if(!isDefined(self.syncedmeleetarget) || !isalive(self.syncedmeleetarget)) {
      break;
    }

    wait 0.1;
  }

  self.ragdoll_immediate = undefined;

  if(self.meleeseq > 0) {
    if(!isDefined(var_0[self.meleeseq])) {
      return;
    }
    self clearanim( % melee_dog, 0.1);
    self setflaggedanimrestart("getupanim", var_0[self.meleeseq], 1, 0.1, 1);
    animscripts\shared::donotetracks("getupanim");
  }

  meleestrugglevsdog_end();
}

meleestrugglevsdog_end() {
  self orientmode("face default");
  self.syncedmeleetarget = undefined;
  self.meleeseq = undefined;
  self.allowpain = 1;
  self.battlechatter = 1;
  self.use_old_dog_attack = undefined;
  self.dog_attacking_me = undefined;
  animscripts\dog\dog_combat::setnextdogattackallowtime(1000);

  if(isDefined(self.olddontattackme)) {
    self.dontattackme = self.olddontattackme;
    self.olddontattackme = undefined;
  }

  self notify("end_melee_all");
}

meleestrugglevsdog_collision() {
  self endon("killanimscript");
  self endon("death");
  self endon("end_melee_all");
  var_0 = self.syncedmeleetarget;

  for(;;) {
    var_1 = var_0 aiphysicstrace(self.origin, var_0.origin, undefined, undefined, 1, 1);

    if(var_1["fraction"] >= 1) {
      wait 0.05;
      continue;
    }

    var_2 = var_1["position"] - var_0.origin;
    var_3 = vectordot(var_2, var_1["normal"]);
    var_4 = self.origin + var_3 * var_1["normal"];
    var_5 = var_4 + (0, 0, 9);
    var_6 = var_4 + (0, 0, -9);
    var_4 = self aiphysicstrace(var_5, var_6);
    self forceteleport(var_4, self.angles, 60);
    wait 0.05;
  }
}

ragdoll_corpses() {
  wait 0.1;
  var_0 = getcorpsearray();

  foreach(var_2 in var_0) {
    if(var_2 isragdoll() == 0) {
      var_2 startragdoll();
    }
  }
}