/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1383.gsc
**************************************/

_id_42E6() {
  _id_42F4();
  thread _id_42E7();
  common_scripts\utility::array_thread(getEntArray("stealth_clipbrush", "targetname"), ::_id_42F3);
}

_id_42E7() {
  var_0 = "_stealth_spotted";

  for(;;) {
    common_scripts\utility::flag_wait("_stealth_enabled");
    common_scripts\utility::flag_wait(var_0);

    if(!common_scripts\utility::flag("_stealth_enabled")) {
      continue;
    }
    _id_42E8("spotted");
    thread _id_42E9();
    common_scripts\utility::flag_waitopen(var_0);

    if(!common_scripts\utility::flag("_stealth_enabled")) {
      continue;
    }
    _id_42E8("hidden");
    waittillframeend;
  }
}

_id_42E8(var_0) {
  level._id_0B6E._id_41ED._id_4220 = var_0;

  foreach(var_4, var_2 in level._id_0B6E._id_41ED._id_425D) {
    setsaveddvar(var_4, var_2[var_0]);
    var_3 = "ai_busyEvent" + getsubstr(var_4, 8);
    setsaveddvar(var_3, var_2[var_0]);
  }
}

_id_42E9() {
  while(common_scripts\utility::flag("_stealth_spotted")) {
    common_scripts\utility::flag_wait("_stealth_enabled");
    var_0 = level._id_0B6E._id_1124.groups;

    foreach(var_4, var_2 in var_0) {
      var_3 = maps\_stealth_shared_utilities::_id_41DC("_stealth_spotted", var_4);

      if(!common_scripts\utility::flag(var_3)) {
        continue;
      }
      thread _id_42EA(var_4);
    }

    common_scripts\utility::flag_waitopen_or_timeout("_stealth_spotted", 1.25);
  }
}

_id_42EA(var_0) {
  var_1 = _id_42EB(var_0);

  if(!var_1) {
    return;
  }
  wait 1;
  var_1 = _id_42EB(var_0);

  if(!var_1) {
    return;
  }
  maps\_stealth_shared_utilities::_id_41E0("_stealth_spotted", var_0);
}

_id_42EB(var_0) {
  var_1 = maps\_stealth_shared_utilities::_id_41E1(var_0);

  foreach(var_4, var_3 in var_1) {
    if(!isalive(var_3.enemy)) {
      continue;
    }
    return 0;
  }

  return 1;
}

_id_42EC() {
  common_scripts\utility::flag_init("_stealth_player_nade");
  level._id_0B6E._id_41ED._id_42ED = 0;
  common_scripts\utility::array_thread(level.players, ::_id_42EE);
}

_id_42EE() {
  for(;;) {
    self waittill("grenade_pullback");
    common_scripts\utility::flag_set("_stealth_player_nade");
    self waittill("grenade_fire", var_0);
    thread _id_42EF(var_0);
  }
}

_id_42EF(var_0) {
  level._id_0B6E._id_41ED._id_42ED++;
  var_0 common_scripts\utility::waittill_notify_or_timeout("death", 10);
  level._id_0B6E._id_41ED._id_42ED--;
  waittillframeend;

  if(!level._id_0B6E._id_41ED._id_42ED) {
    common_scripts\utility::flag_clear("_stealth_player_nade");
  }
}

_id_42F0() {
  common_scripts\utility::array_thread(getEntArray("_stealth_shadow", "targetname"), ::_id_42F1);
  common_scripts\utility::array_thread(getEntArray("stealth_shadow", "targetname"), ::_id_42F1);
}

_id_42F1() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isalive(var_0)) {
      continue;
    }
    if(var_0 maps\_utility::_id_1008("_stealth_in_shadow")) {
      continue;
    }
    var_0 thread _id_42F2(self);
  }
}

_id_42F2(var_0) {
  self endon("death");
  maps\_utility::_id_13DC("_stealth_in_shadow");

  while(self istouching(var_0)) {
    wait 0.05;

  }
  maps\_utility::_id_13DE("_stealth_in_shadow");
}

_id_42F3() {
  self endon("death");

  if(isDefined(self._id_1288)) {
    common_scripts\utility::flag_wait(self._id_1288);

  }
  waittillframeend;
  var_0 = "_stealth_spotted";
  var_1 = "_stealth_found_corpse";
  var_2 = "_stealth_event";

  if(isDefined(self._id_204F)) {
    maps\_stealth_shared_utilities::_id_41E2(maps\_utility::string(self._id_204F));
    var_0 = maps\_stealth_shared_utilities::_id_41DC(var_0, self._id_204F);
    var_1 = maps\_stealth_shared_utilities::_id_41DC(var_1, self._id_204F);
    var_2 = maps\_stealth_shared_utilities::_id_41DC(var_2, self._id_204F);
  }

  self setCanDamage(1);
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "damage");
  level maps\_utility::_id_09C9(common_scripts\utility::flag_wait, var_0);
  level maps\_utility::_id_09C9(common_scripts\utility::flag_wait, var_1);
  level maps\_utility::_id_09C9(common_scripts\utility::flag_wait, var_2);
  maps\_utility::_id_09CB();

  if(self.spawnflags & 1) {
    self connectpaths();

  }
  self delete();
}

_id_42F4() {
  common_scripts\utility::flag_init("_stealth_spotted");
  common_scripts\utility::flag_init("_stealth_event");
  common_scripts\utility::flag_init("_stealth_enabled");
  common_scripts\utility::flag_set("_stealth_enabled");
  level._id_0B6E = spawnStruct();
  level._id_0B6E._id_41ED = spawnStruct();
  level._id_0B6E._id_1124 = spawnStruct();
  level._id_0B6E._id_1124.flags = [];
  level._id_0B6E._id_1124.groups = [];
  level._id_0B6E._id_41ED._id_4220 = "hidden";
  level._id_0B6E._id_41ED._id_4221 = [];
  level._id_0B6E._id_41ED._id_4221["hidden"] = [];
  level._id_0B6E._id_41ED._id_4221["spotted"] = [];
  _id_42F6();
  level._id_0B6E._id_41ED._id_425D = [];
  level._id_0B6E._id_41ED._id_425D["ai_eventDistDeath"] = [];
  level._id_0B6E._id_41ED._id_425D["ai_eventDistPain"] = [];
  level._id_0B6E._id_41ED._id_425D["ai_eventDistExplosion"] = [];
  level._id_0B6E._id_41ED._id_425D["ai_eventDistBullet"] = [];
  level._id_0B6E._id_41ED._id_425D["ai_eventDistFootstep"] = [];
  level._id_0B6E._id_41ED._id_425D["ai_eventDistFootstepWalk"] = [];
  level._id_0B6E._id_41ED._id_425D["ai_eventDistFootstepSprint"] = [];
  level._id_0B6E._id_41ED._id_425D["ai_eventDistGunShot"] = [];
  level._id_0B6E._id_41ED._id_425D["ai_eventDistGunShotTeam"] = [];
  level._id_0B6E._id_41ED._id_425D["ai_eventDistNewEnemy"] = [];
  _id_42F8();
  _id_42E8("hidden");
  _id_42EC();
  _id_42F0();
  maps\_stealth_utility::_id_42F5(0.5);
}

_id_42F6() {
  var_0 = [];
  var_0["prone"] = 70;
  var_0["crouch"] = 600;
  var_0["stand"] = 1024;
  var_1 = [];
  var_1["prone"] = 512;
  var_1["crouch"] = 5000;
  var_1["stand"] = 8000;
  _id_42F7(var_0, var_1);
}

_id_42F7(var_0, var_1) {
  if(isDefined(var_0)) {
    level._id_0B6E._id_41ED._id_4221["hidden"]["prone"] = var_0["prone"];
    level._id_0B6E._id_41ED._id_4221["hidden"]["crouch"] = var_0["crouch"];
    level._id_0B6E._id_41ED._id_4221["hidden"]["stand"] = var_0["stand"];
  }

  if(isDefined(var_1)) {
    level._id_0B6E._id_41ED._id_4221["spotted"]["prone"] = var_1["prone"];
    level._id_0B6E._id_41ED._id_4221["spotted"]["crouch"] = var_1["crouch"];
    level._id_0B6E._id_41ED._id_4221["spotted"]["stand"] = var_1["stand"];
  }
}

_id_42F8() {
  var_0["ai_eventDistDeath"] = [];
  var_0["ai_eventDistPain"] = [];
  var_0["ai_eventDistExplosion"] = [];
  var_0["ai_eventDistBullet"] = [];
  var_0["ai_eventDistFootstep"] = [];
  var_0["ai_eventDistFootstepWalk"] = [];
  var_0["ai_eventDistFootstepSprint"] = [];
  var_0["ai_eventDistGunShot"] = [];
  var_0["ai_eventDistGunShotTeam"] = [];
  var_0["ai_eventDistNewEnemy"] = [];
  var_0["ai_eventDistDeath"]["spotted"] = getdvar("ai_eventDistDeath");
  var_0["ai_eventDistDeath"]["hidden"] = 512;
  var_0["ai_eventDistPain"]["spotted"] = getdvar("ai_eventDistPain");
  var_0["ai_eventDistPain"]["hidden"] = 256;
  var_0["ai_eventDistExplosion"]["spotted"] = 4000;
  var_0["ai_eventDistExplosion"]["hidden"] = 4000;
  var_0["ai_eventDistBullet"]["spotted"] = 96;
  var_0["ai_eventDistBullet"]["hidden"] = 64;
  var_0["ai_eventDistFootstep"]["spotted"] = 350;
  var_0["ai_eventDistFootstep"]["hidden"] = 64;
  var_0["ai_eventDistFootstepWalk"]["spotted"] = 256;
  var_0["ai_eventDistFootstepWalk"]["hidden"] = 32;
  var_0["ai_eventDistFootstepSprint"]["spotted"] = 400;
  var_0["ai_eventDistFootstepSprint"]["hidden"] = 400;
  var_0["ai_eventDistGunShot"]["spotted"] = 2048;
  var_0["ai_eventDistGunShot"]["hidden"] = 2048;
  var_0["ai_eventDistGunShotTeam"]["spotted"] = 750;
  var_0["ai_eventDistGunShotTeam"]["hidden"] = 750;
  var_0["ai_eventDistNewEnemy"]["spotted"] = 750;
  var_0["ai_eventDistNewEnemy"]["hidden"] = 750;
  _id_42F9(var_0);
}

_id_42F9(var_0) {
  foreach(var_6, var_2 in var_0) {
    foreach(var_5, var_4 in var_2) {}
    level._id_0B6E._id_41ED._id_425D[var_6][var_5] = var_4;
  }
}