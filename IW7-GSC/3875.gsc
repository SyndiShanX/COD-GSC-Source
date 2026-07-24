/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3875.gsc
**************************************/

main() {
  if(isDefined(level._id_10E6D)) {
    return;
  }
  init();
  thread _id_B2F1();
  thread _id_115E8();
}

init() {
  scripts\engine\utility::flag_set("stealth_enabled");
  level._id_10E6D = spawnStruct();
  level._id_10E6D._id_53A0 = spawnStruct();
  level._id_10E6D.save = spawnStruct();
  level._id_10E6D._id_0021 = [];
  level._id_10E6D._id_74D5 = [];
  level._id_10E6D._id_53A0.state = "hidden";
  level._id_10E6D._id_53A0._id_DCCA = [];
  level._id_10E6D._id_53A0._id_DCCA["hidden"] = [];
  level._id_10E6D._id_53A0._id_DCCA["spotted"] = [];
  level._id_10E6D._id_53A0.timeout = 5;
  _id_0F19::_id_4683();
  _id_0F1C::_id_6855();
  level._id_10E6D._id_BF5E = 3000;
  level._id_10E6D.group = spawnStruct();
  level._id_10E6D.group.flags = [];
  level._id_10E6D.group.groups = [];
  level._id_10E6D.group._id_1CEF = [];
  _id_F342();
  _id_9720();
  _id_0F27::_id_1B3C();
  level._id_10E6D._id_B739 = 1;
  _id_FA55();
}

_id_FA55() {
  level _id_0F27::_id_F5B4("do_stealth", _id_0F27::_id_57C7);
  level _id_0F27::_id_F5B4("is_in_stealth", _id_0F27::_id_9C1E);
  _id_0F1B::_id_F345();
}

_id_F342() {
  var_0 = [];
  var_0["prone"] = 400;
  var_0["crouch"] = 800;
  var_0["stand"] = 1500;
  var_1 = [];
  var_1["prone"] = 800;
  var_1["crouch"] = 1500;
  var_1["stand"] = 3000;
  _id_0F27::_id_F353(var_0, var_1);
  _id_0F19::_id_F30F();
  _id_95D1();
  _id_0F27::_id_F357(0);
  _id_6806("hidden");
}

_id_95D1() {
  var_0["ai_eventDistDeath"]["spotted"] = getdvarint("ai_eventDistDeath");
  var_0["ai_eventDistDeath"]["hidden"] = 512;
  var_0["ai_eventDistPain"]["spotted"] = getdvarint("ai_eventDistPain");
  var_0["ai_eventDistPain"]["hidden"] = 256;
  var_0["ai_eventDistExplosion"]["spotted"] = getdvarint("ai_eventDistExplosion");
  var_0["ai_eventDistExplosion"]["hidden"] = 2048;
  var_0["ai_eventDistBullet"]["spotted"] = getdvarint("ai_eventDistBullet");
  var_0["ai_eventDistBullet"]["hidden"] = 64;
  var_0["ai_eventDistFootstepWalk"]["spotted"] = getdvarint("ai_eventDistFootstepWalk");
  var_0["ai_eventDistFootstepWalk"]["hidden"] = 50;
  var_0["ai_eventDistFootstep"]["spotted"] = getdvarint("ai_eventDistFootstep");
  var_0["ai_eventDistFootstep"]["hidden"] = 100;
  var_0["ai_eventDistFootstepSprint"]["spotted"] = getdvarint("ai_eventDistFootstepSprint");
  var_0["ai_eventDistFootstepSprint"]["hidden"] = 400;
  var_0["ai_eventDistGunShot"]["spotted"] = getdvarint("ai_eventDistGunShot");
  var_0["ai_eventDistGunShot"]["hidden"] = 2048;
  var_0["ai_eventDistSilencedShot"]["spotted"] = getdvarint("ai_eventDistSilencedShot");
  var_0["ai_eventDistSilencedShot"]["hidden"] = 128;
  var_0["ai_eventDistGunShotTeam"]["spotted"] = getdvarint("ai_eventDistGunShotTeam");
  var_0["ai_eventDistGunShotTeam"]["hidden"] = 750;
  var_0["ai_eventDistNewEnemy"]["spotted"] = getdvarint("ai_eventDistNewEnemy");
  var_0["ai_eventDistNewEnemy"]["hidden"] = 128;
  _id_F395(var_0);
}

_id_F395(var_0) {
  foreach(var_6, var_2 in var_0) {
    foreach(var_5, var_4 in var_2) {
      level._id_10E6D._id_0021[var_6][var_5] = var_4;
    }
  }
}

_id_F354(var_0, var_1) {
  if(isDefined(var_0)) {
    level._id_10E6D._id_53A0._id_DCCA["hidden"]["prone"] = var_0["prone"];
    level._id_10E6D._id_53A0._id_DCCA["hidden"]["crouch"] = var_0["crouch"];
    level._id_10E6D._id_53A0._id_DCCA["hidden"]["stand"] = var_0["stand"];
  }

  if(isDefined(var_1)) {
    level._id_10E6D._id_53A0._id_DCCA["spotted"]["prone"] = var_1["prone"];
    level._id_10E6D._id_53A0._id_DCCA["spotted"]["crouch"] = var_1["crouch"];
    level._id_10E6D._id_53A0._id_DCCA["spotted"]["stand"] = var_1["stand"];
  }
}

_id_B2F1() {
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    _id_0F26::_id_117D1(1);
    setsaveddvar("ai_corpseSynch", 1);
    scripts\engine\utility::flag_wait("stealth_spotted");
    _id_0F26::_id_117D1(0);
    setsaveddvar("ai_corpseSynch", 0);

    if(getdvarint("ai_threatsightDisplay", 1)) {
      foreach(var_1 in level.players) {
        var_1 thread scripts\sp\utility::play_sound_on_entity("ui_stealth_busted");
      }
    }

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }
    _id_6806("spotted");
    thread _id_10E20();
    scripts\engine\utility::flag_waitopen("stealth_spotted");

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }
    _id_6806("hidden");
    waittillframeend;
  }
}

_id_115E8() {
  level._id_10E6D.enemies["axis"] = [];
  level._id_10E6D.enemies["allies"] = [];

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    level._id_10E6D.enemies["axis"] = level.players;
    level._id_10E6D.enemies["allies"] = getaiarray("axis");
    wait 0.05;
  }
}

_id_6806(var_0) {
  level._id_10E6D._id_53A0.state = var_0;

  foreach(var_4, var_2 in level._id_10E6D._id_0021) {
    setsaveddvar(var_4, var_2[var_0]);
    var_3 = "ai_busyEvent" + getsubstr(var_4, 8);
    setsaveddvar(var_3, var_2[var_0]);
  }
}

_id_10E20() {
  while(scripts\engine\utility::flag("stealth_spotted")) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    var_0 = level._id_10E6D.group.groups;

    foreach(var_4, var_2 in var_0) {
      var_3 = _id_0F27::_id_79F6("stealth_spotted", var_4);

      if(!scripts\engine\utility::flag(var_3)) {
        continue;
      }
      var_2 = scripts\engine\utility::array_removeundefined(var_2);

      if(var_2.size > 0) {
        if(var_2[0].team == "allies") {
          continue;
        }
      }

      thread _id_1284D(var_4);
    }

    scripts\engine\utility::flag_waitopen_or_timeout("stealth_spotted", level._id_10E6D._id_53A0.timeout * 1.25);
  }

  var_0 = level._id_10E6D.group.groups;

  foreach(var_4, var_2 in var_0) {
    _id_0F27::_id_868A("stealth_spotted", var_4);
  }
}

_id_1284D(var_0) {
  var_1 = _id_0F27::_id_79F5(var_0);
  scripts\engine\utility::array_thread(var_1, ::_id_C13A, var_0);
  level endon("enemy_" + var_0);

  if(var_1.size > 0) {
    var_2 = _id_3DB9(var_0);

    if(!var_2) {
      return;
    }
    wait(level._id_10E6D._id_53A0.timeout);
    var_2 = _id_3DB9(var_0);

    if(!var_2) {
      return;
    }
  }

  level notify("enemy_" + var_0 + "_stop");
  _id_0F27::_id_868A("stealth_spotted", var_0);
}

_id_C13A(var_0) {
  self notify("notify_level_on_enemy");
  self endon("notify_level_on_enemy");
  var_1 = "enemy_" + var_0;
  self endon("death");
  level endon(var_1);
  level endon(var_1 + "_stop");
  self waittill("enemy");
  level notify(var_1);
}

_id_3DB9(var_0) {
  var_1 = _id_0F27::_id_79F5(var_0);

  foreach(var_4, var_3 in var_1) {
    if(isalive(var_3.enemy)) {
      return 0;
    }
  }

  return 1;
}

_id_9720() {
  scripts\engine\utility::flag_init("stealth_player_nade");
  level._id_10E6D.save._id_D202 = 0;
  scripts\engine\utility::array_thread(level.players, ::_id_D0B1);
}

_id_D0B1() {
  for(;;) {
    self waittill("grenade_pullback");
    scripts\engine\utility::flag_set("stealth_player_nade");
    self waittill("grenade_fire", var_0);
    thread _id_D0B2(var_0);
  }
}

_id_D0B2(var_0) {
  level._id_10E6D.save._id_D202++;
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death", 10);
  level._id_10E6D.save._id_D202--;
  waittillframeend;

  if(!level._id_10E6D.save._id_D202) {
    scripts\engine\utility::flag_clear("stealth_player_nade");
  }
}