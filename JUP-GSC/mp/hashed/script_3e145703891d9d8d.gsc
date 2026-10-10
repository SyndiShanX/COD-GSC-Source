/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e145703891d9d8d.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#namespace tracker_shared;

function function_c1d424f2639c370e(startpos) {
  raycontents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  var_3179cff2e63d0629 = self gettagorigin("j_spineupper");
  castresult = physics_raycast(startpos, var_3179cff2e63d0629, raycontents, undefined, 0, "physicsquery_any", 1);
  return !istrue(castresult);
}

function function_8613a680f1ec0b46(victim, attacker, bundle, startpos) {
  level endon("game_ended");
  victim endon("death_or_disconnect");
  thread function_2b342229b06a657e(victim, attacker, bundle, startpos);
  attacker thread function_ddaa4f3fe17cf7c1(victim);
  result = victim waittill_any_timeout_1(0.25, "death_or_disconnect");
  hashit = result == "timeout" && !istrue(function_f3bb4f4911a1beb2("player", "isInLastStand", victim));

  if(hashit) {
    thread function_210d1e2e0a76f08(victim, attacker, bundle);
  }

  if(isDefined(victim)) {
    victim notify("tracker_projectile_result", hashit);
  }
}

function function_2b342229b06a657e(victim, attacker, bundle, startpos) {
  level endon("game_ended");
  victim endon("death_or_disconnect");
  var_3179cff2e63d0629 = victim gettagorigin("j_spineupper");

  if(getdvarint(@ "hash_9a234ba96b3dd038", 0) > 0) {
    thread scripts\cp_mp\utility\debug_utility::drawline(startpos, var_3179cff2e63d0629, 2, (1, 0, 0));
  }

  if(isDefined(attacker)) {
    projectile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(bundle.trackerprojectile), startpos, var_3179cff2e63d0629, attacker);
  } else {
    projectile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(bundle.trackerprojectile), startpos, var_3179cff2e63d0629);
  }

  projectile missile_settargetEnt(victim, var_3179cff2e63d0629 - victim.origin);
  projectile function_482ef25230b69a53();
  reason = projectile waittill_any_timeout_no_endon_death_1(2, "explode");

  if(reason != "timeout" && isDefined(projectile)) {
    projectile function_542214792d17dce6();
  }
}

function function_210d1e2e0a76f08(victim, attacker, bundle) {
  level endon("game_ended");
  victim endon("death_or_disconnect");
  victim endon("tracker_removed");
  attacker updatedamagefeedback("");
  function_8093c47120b6dec4(victim, attacker);

  if(isagent(attacker)) {
    waitframe();

    foreach(agent in function_2d7fd59d039fa69b(victim.origin, 800, 0)) {
      if(agent.team == attacker.team) {
        if(agent[[agent.fnisinstealthcombat]]()) {
          agent getenemyinfo(victim);
          continue;
        }

        agent aieventlistenerevent("player_snapshotted", victim, victim.origin);
      }
    }

    return;
  }

  if(isPlayer(victim) && istrue(function_f3bb4f4911a1beb2("player", "isReallyAlive", victim))) {
    if(!istrue(victim.var_8d8b284dc948b939)) {
      victim scripts\common\values::set_array("tracker_grenade_tracked", ["weapon_pickup"], 0);
      victim function_628e71176fe11823(attacker);
      victim childthread function_4121acb9b36b21fd(attacker);
      victim childthread function_f6220a0018f6c8de(attacker, bundle);
    } else {
      victim notify("tracker_reset");
    }

    victim.var_8d8b284dc948b939 = 1;
  }
}

function function_628e71176fe11823(attacker) {
  origin = self.origin + anglesToForward(self.angles) * 10;
  self.tracker = spawn("script_origin", origin);
  self.tracker setModel("tag_origin");
  self.tracker linkTo(self);
  self.tracker.trackedplayer = self;
  self.tracker.owner = attacker;
  self.tracker.team = attacker.team;

  if(!isDefined(level.trackers)) {
    level.trackers = [];
  }

  level.trackers[self.tracker getentitynumber()] = self.tracker;
}

function function_f6220a0018f6c8de(attacker, bundle) {
  childthread function_bfc3ae90fa9569c9(attacker, bundle);
  function_d9a426f85d07e227(attacker, bundle);
  childthread function_865eedb19037c3a7(attacker, bundle);
  childthread function_a86cffe7d22fd360(attacker, bundle);
  childthread function_61e49f0e63f71c05();
  thread function_d4a6bd543c710282(attacker, bundle);
}

function function_7a7f279e668a106a(text, time) {
  self notify("tracker_setting_hint_text");
  self endon("tracker_setting_hint_text");
  childthread function_f3bb4f4911a1beb2("game", "tutorialPrint", text, time);
}

function function_a86cffe7d22fd360(attacker, bundle) {
  activetime = getdvarint(@ "hash_a3436ebaeb0a3cbd", bundle.trackerlifetime);

  for(var_3d965ba84cdbd358 = 0; !var_3d965ba84cdbd358; var_3d965ba84cdbd358 = result == "timeout") {
    result = waittill_notify_or_timeout_return("tracker_reset", activetime);
  }

  function_bf0dc21483385b04(attacker, bundle);
}

function function_865eedb19037c3a7(attacker, bundle) {
  if(issharedfuncdefined("killstreak", "setKillstreakControlPriority")) {
    var_4dfdc6571c27665b = self usinggamepad() ? &"EQUIPMENT/TRACKER_GRENADE_HOLD" : &"EQUIPMENT/TRACKER_GRENADE_HOLD_KB";
    self.tracker[[getsharedfunc("killstreak", "setKillstreakControlPriority")]](self, var_4dfdc6571c27665b, 360, 360, 65535, 65535, 1);
  }

  self.tracker function_dfb78b3e724ad620(1);
  self.tracker setuseholdduration(300);
  holdtimer = 0;
  self.var_4bba381fcacc4a4a = 0;
  holdtime = getdvarfloat(@ "hash_e259cbab7b3ad588", bundle.var_6112f4a7b9e1f7ca);

  while(holdtimer < holdtime) {
    if(!self.var_4bba381fcacc4a4a) {
      self.tracker waittill("trigger");
      self.var_4bba381fcacc4a4a = 1;
      self setclientomnvar("ui_securing", 29);
      scripts\cp_mp\utility\weapon_utility::giveandfireoffhandreliable(makeweapon("gesture_tracker_grenade_remove_mp"));
      self notify("remove_tracker_button_press_started");
    }

    buttonpressed = self useButtonPressed();

    if(buttonpressed) {
      progresspercentage = min(holdtimer / holdtime, 1);
      self setclientomnvar("ui_securing_progress", progresspercentage);
      holdtimer += level.framedurationseconds;
      waitframe();
      continue;
    }

    if(!buttonpressed && self.var_4bba381fcacc4a4a) {
      holdtimer = 0;
      self.var_4bba381fcacc4a4a = 0;
      function_6ca4812fa32b9968();
      self notify("remove_tracker_button_press_canceled");
    }
  }

  function_bf0dc21483385b04(attacker, bundle);
}

function function_6ca4812fa32b9968() {
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_securing_progress", 0);
}

function function_bfc3ae90fa9569c9(attacker, bundle) {
  self waittill("stop_tracker_grenade_thirdparty", var_e2b6708ab0acbb38, weapon);

  if(isDefined(var_e2b6708ab0acbb38) && isPlayer(var_e2b6708ab0acbb38) && issharedfuncdefined("player", "doScoreEvent")) {
    var_e2b6708ab0acbb38 thread function_f3bb4f4911a1beb2("player", "doScoreEvent", #"destroyed_equipment", weapon);
  }

  function_bf0dc21483385b04(attacker, bundle);
}

function function_d9a426f85d07e227(attacker, bundle) {
  self.tracker scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_5fc7c9ae178ffefb);
  self.tracker function_f3bb4f4911a1beb2("emp", "setEMP_Applied_Callback", &function_5fc7c9ae178ffefb);
}

function function_5fc7c9ae178ffefb(data) {
  self.trackedplayer notify("stop_tracker_grenade_thirdparty", data.attacker, data.objweapon);
}

function function_d4a6bd543c710282(attacker, bundle) {
  level endon("game_ended");
  self endon("tracker_removed");
  self waittill("death_or_disconnect");
  function_bf0dc21483385b04(attacker, bundle, 1);
}

function function_bf0dc21483385b04(attacker, bundle, var_15f3348c8454a245) {
  if(isDefined(self)) {
    scripts\common\values::reset_all("tracker_grenade_tracked");

    if(isPlayer(self)) {
      self.var_8d8b284dc948b939 = undefined;

      if(istrue(self.var_4bba381fcacc4a4a)) {
        function_6ca4812fa32b9968();
      }

      self.var_4bba381fcacc4a4a = undefined;
      self stoploopsound("eqp_tracker_grenade_attached_active_beep");

      if(!istrue(var_15f3348c8454a245)) {
        var_54a1d70014cdc91d = getdvarint(@ "hash_ff7342ea5798e687", bundle.var_d0e06a25c0f68c72);
        thread function_7a7f279e668a106a(&"EQUIPMENT/TRACKER_GRENADE_END", var_54a1d70014cdc91d);
      }

      thread function_be2d7b4d68f1d36a(attacker);

      if(isDefined(self.tracker)) {
        level.trackers[self.tracker getentitynumber()] = undefined;
        self.tracker delete();
      }
    }

    self notify("tracker_removed");
  }
}

function function_61e49f0e63f71c05() {
  while(true) {
    self waittill("last_stand_start");
    self.tracker function_dfb78b3e724ad620(0);
    function_efe4706df8361219("last_stand_heal_success", "last_stand_revived", "last_stand_self_revive");
    self.tracker function_dfb78b3e724ad620(1);
  }
}

function function_4121acb9b36b21fd(owner) {
  if(function_21322da268e71c19()) {
    owner function_f3bb4f4911a1beb2("player", "showMiniMap");
  }

  radartype = getdvarint(@ "hash_b34047f59b5f5b03", 6);
  radius = getdvarint(@ "hash_3b3ac1542032df99", 25);
  sweeptime = getdvarint(@ "hash_ebef7f9725747c87", 50);

  if(radartype == getuavstrengthlevelshowenemydirectional()) {
    owner.radarstrength = getuavstrengthlevelshowenemydirectional();
    owner.radarshowenemydirection = 1;
    owner.var_7daf8331a040c860 = 1;
  }

  if(level.teambased) {
    foreach(player in level.players) {
      if(player.pers["team"] == owner.team && radartype == getuavstrengthlevelshowenemydirectional()) {
        player.radarstrength = getuavstrengthlevelshowenemydirectional();
        player.radarshowenemydirection = 1;
        player.var_7daf8331a040c860 = 1;
      }
    }
  }

  while(true) {
    if(level.teambased) {
      triggerportableradarpingteam(self.origin, owner.team, radius, sweeptime, radartype);
    } else {
      triggerportableradarping(self.origin, owner, radius, sweeptime, undefined, radartype);
    }

    waitframe();
  }
}

function function_be2d7b4d68f1d36a(owner) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(function_21322da268e71c19()) {
    owner function_f3bb4f4911a1beb2("player", "hideMiniMap");
  }

  if(level.teambased) {
    foreach(player in level.players) {
      if(player.pers["team"] == owner.team) {
        player.radarstrength = getuavstrengthlevelneutral();
        player.radarshowenemydirection = 0;
        player.var_7daf8331a040c860 = 0;
      }
    }

    return;
  }

  owner.radarstrength = getuavstrengthlevelneutral();
  owner.radarshowenemydirection = 0;
  owner.var_7daf8331a040c860 = 0;
}

function function_482ef25230b69a53() {
  self setscriptablepartstate("vfx", "deploy", 0);
}

function function_542214792d17dce6() {
  self setscriptablepartstate("vfx", "off", 0);
}

function function_8093c47120b6dec4(victim, attacker) {
  foreach(player in level.players) {
    if(isDefined(player) && isDefined(self)) {
      if(player == victim) {
        self playsoundtoplayer("eqp_tracker_grenade_attach_plr_victim", player, victim);
        continue;
      }

      if(player == attacker) {
        self playsoundtoplayer("eqp_tracker_grenade_attach_plr_attacker", player, victim);
        continue;
      }

      self playsoundtoplayer("eqp_tracker_grenade_attach", player, victim);
    }
  }

  if(isPlayer(victim) && !istrue(victim.var_8d8b284dc948b939)) {
    victim playLoopSound("eqp_tracker_grenade_attached_active_beep");
  }
}

function function_ddaa4f3fe17cf7c1(victim) {
  level endon("game_ended");
  victim endon("death_or_disconnect");
  self endon("tracker_set_activated_ux");
  victim waittill("tracker_projectile_result", result);

  if(istrue(result)) {
    thread function_8f56afa7a5e897d0(victim);
    self notify("tracker_set_activated_ux");
  }
}

function function_8f56afa7a5e897d0(victim) {
  level endon("game_ended");

  if(istrue(function_f3bb4f4911a1beb2("player", "isReallyAlive", self))) {
    self setclientomnvar("ui_show_tracker_activated", 1);
  }

  victim waittill_any_timeout_no_endon_death_1(2.5, "tracker_removed");
  self setclientomnvar("ui_show_tracker_activated", 0);
}