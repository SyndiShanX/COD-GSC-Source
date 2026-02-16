/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_util.gsc
*****************************************************/

player_start(var_0) {
  var_1 = getent(var_0, "targetname");
  level.player setorigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
}

player_setup() {
  level.player.animname = "player";
  level.player setthreatbiasgroup("player");
  level.player thread fire_death_watcher();
  level.player thread ammo_hack();
}

ammo_hack(var_0) {
  while(!isDefined(var_0) || var_0.size == 0) {
    var_0 = self getweaponslistall();
    wait 0.05;
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    self givestartammo(var_0[var_1]);
}

fire_death_watcher(var_0, var_1) {
  for(;;) {
    common_scripts\utility::flag_wait("flag_fire_damage_on");
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_1) && var_1.classname != "worldspawn") {
      if(var_1 == level._fire_damage_ent && self.health - var_0 <= 0) {
        setDvar("ui_deadquote", &"BLACK_ICE_DEATH_FIRE");
        maps\_utility::missionfailedwrapper();
      }
    }
  }
}

exploder_damage_loop(var_0, var_1) {
  var_2 = [];
  var_3 = maps\_utility::get_exploder_array(var_0);

  foreach(var_5 in var_3) {
    if(isDefined(var_5.v["damage"]) && var_5.v["damage"] > 0) {
      var_5.v["origin"] = getgroundposition(var_5.v["origin"], 1);
      var_2 = common_scripts\utility::array_add(var_2, var_5);
    }
  }

  if(!isDefined(level._fires))
    level._fires = [];

  level._fires[var_0] = var_2;

  while(var_2.size > 0) {
    common_scripts\utility::flag_wait("flag_fire_damage_on");
    level._fires[var_0] = var_2;

    foreach(var_5 in var_2) {
      if(isDefined(var_5.looper)) {
        var_5 thread fire_damage(var_1);
        continue;
      }

      var_2 = common_scripts\utility::array_remove(var_2, var_5);
    }

    wait 0.1;
  }
}

fire_damage(var_0, var_1) {
  if(isDefined(self.v["delay"]))
    var_2 = self.v["delay"];
  else
    var_2 = 1;

  if(isDefined(self.v["damage_radius"]))
    var_3 = self.v["damage_radius"];
  else
    var_3 = 128;

  if(!isDefined(var_1))
    var_1 = 4;

  var_4 = self.v["origin"];
  wait(var_2);
  radiusdamage(var_4, var_3, var_1, var_1, var_0);
}

add_fire(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(isDefined(var_1))
    var_4.v["origin"] = var_1;

  if(isDefined(var_2))
    var_4.v["damage_radius"] = var_2;

  if(isDefined(var_3))
    var_4.v["delay"] = var_3;

  level._fires[var_0] = common_scripts\utility::array_add(level._fires[var_0], var_4);
}

normalize_value(var_0, var_1, var_2) {
  if(var_2 > var_1)
    return 1.0;
  else if(var_2 < var_0)
    return 0.0;

  return (var_2 - var_0) / (var_1 - var_0);
}

factor_value_min_max(var_0, var_1, var_2) {
  return var_1 * var_2 + var_0 * (1 - var_2);
}

spawn_allies() {
  var_0 = 2;
  var_1 = getEntArray("spawner_allies", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::spawnfunc_ally);
  level._allies = spawn_allies_group(var_1);
  maps\_utility::delaythread(0.05, maps\_utility::set_team_bcvoice, "allies", "taskforce");
}

spawn_allies_swim() {
  var_0 = getEntArray("spawner_allies_swim", "script_noteworthy");
  var_1 = spawn_allies_group(var_0, 1);
  var_2 = [];
  var_2[0] = var_1[0];
  var_2[1] = var_1[1];
  return var_2;
}

spawn_allies_group(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(issubstr(var_4.targetname, "ally_01")) {
      var_4.script_friendname = "Merrick";
      var_5 = var_4 maps\_utility::spawn_ai();
      var_5.animname = "ally1";
      var_5.v.invincible = 1;
      var_2[0] = var_5;
      continue;
    }

    if(issubstr(var_4.targetname, "ally_02")) {
      if(isDefined(var_1) && var_1)
        var_4.script_friendname = "Kick";
      else
        var_4.script_friendname = "Hesh";

      var_5 = var_4 maps\_utility::spawn_ai();
      var_5.animname = "ally2";
      var_5.v.invincible = 1;
      var_2[1] = var_5;
      continue;
    }
  }

  return var_2;
}

spawnfunc_ally() {
  maps\_utility::set_archetype("black_ice_ally");
  maps\_utility::magic_bullet_shield();
  self.hero = 1;
}

teleport_allies(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1 = common_scripts\utility::array_add(var_1, common_scripts\utility::getstruct(var_3, "targetname"));

  if(var_1.size == 0) {
    foreach(var_3 in var_0) {
      var_6 = getent(var_3, "targetname");
      var_1 = common_scripts\utility::array_add(var_1, var_6);
    }
  }

  if(var_1.size != self.size) {}

  for(var_8 = 0; var_8 < self.size; var_8++) {
    if(!isDefined(var_1[var_8].angles))
      var_1[var_8].angles = self[var_8].angles;

    self[var_8] forceteleport(var_1[var_8].origin, var_1[var_8].angles);
  }
}

spawn_bravo() {
  var_0 = getEntArray("spawner_bravo", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 maps\_utility::add_spawn_function(::spawnfunc_bravo);

  level._bravo = spawn_bravo_group(var_0);
  maps\_utility::delaythread(0.05, maps\_utility::set_team_bcvoice, "allies", "taskforce");
}

spawn_bravo_group(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(issubstr(var_3.targetname, "bravo_01")) {
      var_3.script_friendname = "Keegan";
      var_4 = var_3 maps\_utility::spawn_ai();
      var_4.disable_sniper_glint = 1;
      var_4.animname = "bravo1";
      var_1[0] = var_4;
      continue;
    }

    if(issubstr(var_3.targetname, "bravo_02")) {
      var_3.script_friendname = "Kick";
      var_4 = var_3 maps\_utility::spawn_ai();
      var_4.animname = "bravo2";
      var_1[1] = var_4;
      continue;
    }
  }

  return var_1;
}

spawnfunc_bravo() {
  maps\_utility::magic_bullet_shield();
}

hide_dufflebag() {
  var_0 = [];
  var_0[var_0.size] = "J_Cog";
  var_0[var_0.size] = "J_Strap_Base";
  var_0[var_0.size] = "J_Strap_End";
  var_0[var_0.size] = "J_Strap_1";
  var_0[var_0.size] = "J_Strap_2";
  var_0[var_0.size] = "J_Strap_3";
  var_0[var_0.size] = "J_Strap_4";
  var_0[var_0.size] = "J_Strap_5";
  var_0[var_0.size] = "J_Strap_6";
  var_0[var_0.size] = "J_Strap_7";
  var_0[var_0.size] = "J_Strap_8";
  var_0[var_0.size] = "J_Strap_9";
  var_0[var_0.size] = "J_Strap_10";
  var_0[var_0.size] = "J_Strap_11";
  var_0[var_0.size] = "J_Strap_12";
  var_0[var_0.size] = "J_Strap_13";
  var_0[var_0.size] = "J_Strap_14";

  foreach(var_2 in var_0)
  self hidepart(var_2);
}

ai_alert_range(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("alert");
  var_5 = var_1 * var_1;

  for(;;) {
    var_6 = distancesquared(self.origin, var_0.origin);

    if(distancesquared(self.origin, var_0.origin) <= var_5) {
      if(isDefined(var_2) && var_2) {
        if(self cansee(var_0)) {
          break;
        }
      } else
        break;
    }

    wait 0.05;
  }

  thread ai_alert(var_3, var_4);
}

ai_alert_bullet(var_0, var_1) {
  self endon("death");
  self endon("alert");

  for(;;) {
    self waittill("bulletwhizby", var_2, var_3);

    if(var_3 < 70.0 && var_2 getthreatbiasgroup() == "alpha") {
      break;
    }
  }

  thread ai_alert(var_0, var_1);
}

ai_alert_damage(var_0, var_1) {
  self endon("death");
  self endon("alert");
  var_2 = var_1;

  if(isstring(var_2)) {
    var_3 = maps\_utility::get_ai_group_ai(var_2);

    foreach(var_5 in var_3) {
      if(var_5 != self)
        var_5 thread ai_alert_friend_death(self, 0, 0);
    }

    var_2 = 1;
  }

  if(var_2 && isDefined(self.script_aigroup)) {
    var_3 = maps\_utility::get_ai_group_ai(self.script_aigroup);

    foreach(var_5 in var_3) {
      if(var_5 != self)
        var_5 thread ai_alert_friend_death(self, 0, 0);
    }
  }

  for(;;) {
    self waittill("damage", var_9, var_10);

    if(var_10 getthreatbiasgroup() == "alpha") {
      break;
    }
  }

  thread ai_alert(var_0, var_1);
}

ai_alert_friend_death(var_0, var_1, var_2) {
  self endon("death");
  self endon("alert");
  self notify(var_0.unique_id);
  self endon(var_0.unique_id);
  var_0 waittill("death");
  thread ai_alert(var_1, var_2);
}

ai_alert(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  self stopanimscripted();
  maps\_utility::enable_danger_react(10);
  maps\_utility::clear_run_anim();
  maps\_utility::clear_deathanim();

  if(var_0 && isDefined(self.surprise_anims)) {
    self.animname = "generic";
    var_2 = self.surprise_anims;
    thread maps\_anim::anim_single_solo(self, common_scripts\utility::random(var_2));
    self.allowdeath = 1;
    wait(randomfloatrange(0.7, 1.0));
    self stopanimscripted();
  }

  self notify("stop_going_to_node");

  if(self getthreatbiasgroup() != "axis") {
    setthreatbias(self getthreatbiasgroup(), "alpha", 100);
    setthreatbias("alpha", self getthreatbiasgroup(), 100);
  } else {
    maps\_utility::set_ignoreall(0);
    maps\_utility::set_ignoreme(0);
  }

  thread maps\_utility::gun_recall();

  if(isstring(var_1)) {
    var_3 = maps\_utility::get_ai_group_ai(var_1);

    foreach(var_5 in var_3) {
      if(var_5 != self)
        var_5 thread ai_alert(0, 0);
    }

    var_1 = 1;
  }

  if(var_1 && isDefined(self.script_aigroup)) {
    var_3 = maps\_utility::get_ai_group_ai(self.script_aigroup);

    foreach(var_5 in var_3) {
      if(var_5 != self)
        var_5 thread ai_alert(0, 0);
    }
  }

  self notify("alert");
}

flash_grenade_proc(var_0, var_1) {
  var_2 = var_0 gettagorigin("J_Wrist_LE");
  var_3 = getent(var_1, "targetname");
  var_3 = var_3.origin;
  var_4 = distance(var_3, var_0.origin) * 2.0;
  var_4 = clamp(var_4, 300, 1000);
  var_5 = vectornormalize(var_3 - var_0.origin);
  var_6 = var_5 * var_4;
  magicgrenademanual("flash_grenade", var_2, var_6, 1.0);
}

delay_retreat(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_2))
    thread opfor_retreat(var_0, var_2, var_3, var_4, var_5, var_6);

  common_scripts\utility::flag_wait_or_timeout(var_3, var_1);

  if(common_scripts\utility::flag(var_3)) {
    return;
  }
  thread retreat_proc(var_3, var_4, var_5, var_6);
}

opfor_retreat(var_0, var_1, var_2, var_3, var_4, var_5) {
  while(maps\_utility::get_ai_group_sentient_count(var_0) > var_1 && !common_scripts\utility::flag(var_2))
    wait 0.1;

  if(common_scripts\utility::flag(var_2)) {
    return;
  }
  thread retreat_proc(var_2, var_3, var_4, var_5);
}

retreat_proc(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && !isarray(var_1))
    var_1 = [var_1];

  if(isDefined(var_1)) {
    var_4 = [];

    foreach(var_6 in var_1) {
      var_6 = getent(var_6, "targetname");

      if(isDefined(var_6))
        var_4[var_4.size] = var_6;
    }

    if(var_4.size > 0)
      var_1 = var_4;
    else
      var_1 = undefined;
  }

  if(isDefined(var_1)) {
    var_1[0] notify("trigger");

    if(isDefined(var_2) && var_2)
      common_scripts\utility::array_thread(var_1, common_scripts\utility::trigger_off);
  }

  if(!common_scripts\utility::flag(var_0))
    common_scripts\utility::flag_set(var_0);

  if(isDefined(var_3) && !isarray(var_3))
    var_3 = [var_3];

  if(isDefined(var_3)) {
    foreach(var_9 in var_3)
    level notify(var_9);
  }
}

temp_dialogue_line(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level.dialogue_huds))
    level.dialogue_huds = [];

  var_3 = 0;

  for(;;) {
    if(!isDefined(level.dialogue_huds[var_3])) {
      break;
    }

    var_3++;
  }

  var_4 = "^3";

  if(!isDefined(var_2))
    var_2 = 1;

  var_2 = max(1, var_2);
  level.dialogue_huds[var_3] = 1;
  var_5 = maps\_hud_util::createfontstring("default", 1.5);
  var_5.location = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.alpha = 0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 1;
  var_5.x = 40;
  var_5.y = 260 + var_3 * 18;
  var_5.label = " " + var_4 + "< " + var_0 + " > ^7" + var_1;
  var_5.color = (1, 1, 1);
  wait(var_2);
  var_6 = 10.0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 0;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_5.color = (1, 1, 0 / (var_6 - var_7));
    wait 0.05;
  }

  wait 0.25;
  var_5 destroy();
  level.dialogue_huds[var_3] = undefined;
}

check_anim_time(var_0, var_1, var_2) {
  var_3 = self getanimtime(level.scr_anim[var_0][var_1]);

  if(var_3 >= var_2)
    return 1;

  return 0;
}

delete_at_anim_end(var_0, var_1, var_2) {
  while(!check_anim_time(var_0, var_1, 1.0))
    wait(level.timestep);

  if(isDefined(var_2) && var_2)
    maps\_vignette_util::vignette_actor_delete();
  else
    self delete();
}

ignore_everything() {
  if(isDefined(self._ignore_settings_old))
    unignore_everything();

  self._ignore_settings_old = [];
  self.disableplayeradsloscheck = set_ignore_setting(self.disableplayeradsloscheck, "disableplayeradsloscheck", 1);
  self.ignoreall = set_ignore_setting(self.ignoreall, "ignoreall", 1);
  self.ignoreme = set_ignore_setting(self.ignoreme, "ignoreme", 1);
  self.grenadeawareness = set_ignore_setting(self.grenadeawareness, "grenadeawareness", 0);
  self.ignoreexplosionevents = set_ignore_setting(self.ignoreexplosionevents, "ignoreexplosionevents", 1);
  self.ignorerandombulletdamage = set_ignore_setting(self.ignorerandombulletdamage, "ignorerandombulletdamage", 1);
  self.ignoresuppression = set_ignore_setting(self.ignoresuppression, "ignoresuppression", 1);
  self.dontavoidplayer = set_ignore_setting(self.dontavoidplayer, "dontavoidplayer", 1);
  self.newenemyreactiondistsq = set_ignore_setting(self.newenemyreactiondistsq, "newEnemyReactionDistSq", 0);
  self.disablebulletwhizbyreaction = set_ignore_setting(self.disablebulletwhizbyreaction, "disableBulletWhizbyReaction", 1);
  self.disablefriendlyfirereaction = set_ignore_setting(self.disablefriendlyfirereaction, "disableFriendlyFireReaction", 1);
  self.dontmelee = set_ignore_setting(self.dontmelee, "dontMelee", 1);
  self.flashbangimmunity = set_ignore_setting(self.flashbangimmunity, "flashBangImmunity", 1);
  self.dodangerreact = set_ignore_setting(self.dodangerreact, "doDangerReact", 0);
  self.neversprintforvariation = set_ignore_setting(self.neversprintforvariation, "neverSprintForVariation", 1);
  self.a.disablepain = set_ignore_setting(self.a.disablepain, "a.disablePain", 1);
  self.allowpain = set_ignore_setting(self.allowpain, "allowPain", 0);
  self pushplayer(1);
}

set_ignore_setting(var_0, var_1, var_2) {
  if(isDefined(var_0))
    self._ignore_settings_old[var_1] = var_0;
  else
    self._ignore_settings_old[var_1] = "none";

  return var_2;
}

unignore_everything(var_0) {
  if(isDefined(var_0) && var_0) {
    if(isDefined(self._ignore_settings_old))
      self._ignore_settings_old = undefined;
  }

  self.disableplayeradsloscheck = restore_ignore_setting("disableplayeradsloscheck", 0);
  self.ignoreall = restore_ignore_setting("ignoreall", 0);
  self.ignoreme = restore_ignore_setting("ignoreme", 0);
  self.grenadeawareness = restore_ignore_setting("grenadeawareness", 1);
  self.ignoreexplosionevents = restore_ignore_setting("ignoreexplosionevents", 0);
  self.ignorerandombulletdamage = restore_ignore_setting("ignorerandombulletdamage", 0);
  self.ignoresuppression = restore_ignore_setting("ignoresuppression", 0);
  self.dontavoidplayer = restore_ignore_setting("dontavoidplayer", 0);
  self.newenemyreactiondistsq = restore_ignore_setting("newEnemyReactionDistSq", 262144);
  self.disablebulletwhizbyreaction = restore_ignore_setting("disableBulletWhizbyReaction", undefined);
  self.disablefriendlyfirereaction = restore_ignore_setting("disableFriendlyFireReaction", undefined);
  self.dontmelee = restore_ignore_setting("dontMelee", undefined);
  self.flashbangimmunity = restore_ignore_setting("flashBangImmunity", undefined);
  self.dodangerreact = restore_ignore_setting("doDangerReact", 1);
  self.neversprintforvariation = restore_ignore_setting("neverSprintForVariation", undefined);
  self.a.disablepain = restore_ignore_setting("a.disablePain", 0);
  self.allowpain = restore_ignore_setting("allowPain", 1);
  self pushplayer(0);
  self._ignore_settings_old = undefined;
}

restore_ignore_setting(var_0, var_1) {
  if(isDefined(self._ignore_settings_old)) {
    if(isstring(self._ignore_settings_old[var_0]) && self._ignore_settings_old[var_0] == "none")
      return var_1;
    else
      return self._ignore_settings_old[var_0];
  }

  return var_1;
}

quake(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0.0;

  level.player playSound(var_0);
  wait(var_1);
  earthquake(0.5, 1, level.player.origin, 3000);
}

array_thread_targetname(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = getEntArray(var_0, "targetname");

  if(var_11.size > 0)
    common_scripts\utility::array_thread(var_11, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

trig_stairs_setup() {
  level endon("turn_off_stairs_trigs");
  var_0 = getEntArray("trig_stairs", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, ::trig_stairs_proc);
}

trig_stairs_proc() {
  level endon("turn_off_stairs_trigs");
  var_0 = undefined;

  if(isDefined(self.script_parameters) && self.script_parameters == "allow_cqb")
    var_0 = 1;

  for(;;) {
    self waittill("trigger", var_1);

    if(!isDefined(var_1.instairstrig))
      var_1 thread ai_stairs_proc(self, var_0);
  }
}

ai_stairs_proc(var_0, var_1) {
  self endon("death");
  self.instairstrig = 1;

  if(isPlayer(self))
    thread maps\_utility::blend_movespeedscale(0.6);
  else {
    if(!isDefined(var_1) && isDefined(self.cqbwalking)) {
      self.wascqb = 1;
      thread maps\_utility::disable_cqbwalk();
    }

    self.old_move_rate = self.moveplaybackrate;
    maps\_utility::set_moveplaybackrate(1.25, 0.25);
  }

  while(self istouching(var_0)) {
    if(isPlayer(self) && !isDefined(self.stairs_low_speed)) {
      var_2 = common_scripts\utility::getclosest(self.origin, level._allies, 128);

      if(isDefined(var_2) && common_scripts\utility::within_fov(level.player.origin, level.player.angles, var_2.origin, 0)) {
        self.stairs_low_speed = 1;
        thread maps\_utility::blend_movespeedscale(0.5);
      }
    }

    wait 0.05;
  }

  if(isPlayer(self)) {
    if(isDefined(self.stairs_low_speed))
      thread maps\_utility::blend_movespeedscale_default(0.4);
    else
      thread maps\_utility::blend_movespeedscale_default(0.25);
  } else {
    if(isDefined(self.wascqb)) {
      self.wascqb = undefined;
      thread maps\_utility::enable_cqbwalk();
    }

    maps\_utility::set_moveplaybackrate(self.old_move_rate, 0.25);
  }

  self.instairstrig = undefined;
  self.stairs_low_speed = undefined;
}

waittill_trigger_ent_targetname(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0, "targetname");
  var_4 waittill_trigger_ent(var_1, var_2, var_3);
}

waittill_trigger_ent(var_0, var_1, var_2) {
  var_3 = [];

  if(isarray(var_0))
    var_3 = var_0;
  else
    var_3[0] = var_0;

  var_4 = 0;
  var_5 = var_3;

  for(;;) {
    self waittill("trigger", var_6);

    foreach(var_8 in var_5) {
      if(var_8 == var_6) {
        var_4++;
        var_5 = common_scripts\utility::array_remove(var_5, var_8);

        if(isDefined(var_1)) {
          if(isDefined(var_2))
            var_6 thread[[var_1]](var_2);
          else
            var_6 thread[[var_1]]();
        }

        break;
      }
    }

    if(var_4 == var_3.size) {
      break;
    }
  }
}

getentany(var_0, var_1) {
  var_2 = "targetname";

  if(isDefined(var_1))
    var_2 = var_1;

  var_3 = undefined;
  var_3 = getEntArray(var_0, var_2);

  if(var_3.size == 0)
    var_3 = common_scripts\utility::getStructArray(var_0, var_2);
  else if(var_3.size == 1)
    return var_3[0];
  else
    return var_3;

  if(var_3.size == 0)
    var_3 = getnodearray(var_0, var_2);
  else if(var_3.size == 1)
    return var_3[0];
  else
    return var_3;

  if(var_3.size == 0)
    var_3 = getvehiclenodearray(var_0, var_2);
  else if(var_3.size == 1)
    return var_3[0];
  else
    return var_3;

  if(var_3.size == 0) {
    return;
  }
  if(var_3.size == 1)
    return var_3[0];
  else {
    return var_3;
    return;
  }
}

setup_door(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isstring(var_0))
    var_3 = getent(var_0, "targetname");
  else
    var_3 = var_0;

  if(var_3.classname != "script_model" && var_3.classname != "script_brushmodel") {}

  var_4 = undefined;

  if(isDefined(var_3.target)) {
    var_5 = getEntArray(var_3.target, "targetname");

    foreach(var_7 in var_5) {
      if(var_7.classname == "script_brushmodel") {
        var_4 = var_7;
        continue;
      }

      if(var_7.classname == "script_origin") {
        if(!isDefined(var_2)) {
          var_3.hinge = var_7;
          var_3.hinge.tag_name = var_2;
          var_3 linkto(var_3.hinge);
        }
      }
    }
  }

  if(isDefined(var_2)) {
    var_3.hinge = common_scripts\utility::spawn_tag_origin();
    var_3.hinge.origin = var_3 gettagorigin(var_2);
    var_3.hinge.angles = var_3 gettagangles(var_2);

    if(!isDefined(var_1))
      var_3 linkto(var_3.hinge);
  }

  if(isDefined(var_4)) {
    var_3.col_brush = var_4;

    if(isDefined(var_2))
      var_3.col_brush linkto(var_3, var_2);
    else
      var_3.col_brush linkto(var_3);
  } else if(var_3.classname == "script_brushmodel")
    var_3.col_brush = var_3;

  var_3.original_angles = var_3.angles;

  if(isDefined(var_1))
    var_3 maps\_utility::assign_animtree(var_1);

  return var_3;
}

rebuild_door(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = var_0.animname;
  var_4 = var_0.original_angles;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(var_0.targetname))
    var_5 = var_0.targetname;

  if(isDefined(var_0.target))
    var_6 = var_0.target;

  if(isDefined(var_0.hinge))
    var_7 = var_0.hinge.tag_name;

  var_0 delete();
  var_0 = maps\_utility::spawn_anim_model(var_3, var_1);
  var_0.angles = var_2;
  var_0.target = var_6;
  var_0 = setup_door(var_0, var_3, var_7);
  var_0.original_angles = var_4;
  return var_0;
}

close_door(var_0, var_1, var_2) {
  var_3 = self;

  if(isDefined(self._lastanimtime)) {
    self._lastanimtime = undefined;
    self stopuseanimtree();
  }

  var_4 = undefined;

  if(isDefined(var_3.hinge)) {
    if(!var_3 islinked())
      var_3 linkto(var_3.hinge);

    var_4 = var_3.hinge;
  } else
    var_4 = var_3;

  var_5 = 0.05;

  if(isDefined(var_1))
    var_5 = var_1;

  if(isDefined(var_0))
    var_4 rotateyaw(var_0, var_5);
  else
    var_4 rotateto(var_3.original_angles, var_5);

  if(isDefined(var_2))
    wait(var_2);
  else
    wait(var_5);

  if(isDefined(var_3.col_brush))
    var_3.col_brush disconnectpaths();
}

open_door(var_0, var_1, var_2) {
  var_3 = self;

  if(isDefined(self._lastanimtime)) {
    self._lastanimtime = undefined;
    self stopuseanimtree();
  }

  var_4 = undefined;

  if(isDefined(var_3.hinge)) {
    if(!var_3 islinked())
      var_3 linkto(var_3.hinge);

    var_4 = var_3.hinge;
  } else
    var_4 = var_3;

  var_5 = undefined;
  var_6 = undefined;

  if(isarray(var_0)) {
    var_5 = var_0[0];
    var_6 = var_0[1];
  } else
    var_5 = var_0;

  var_7 = 0.05;

  if(isDefined(var_1))
    var_7 = var_1;

  var_4 rotateyaw(var_5, var_7);

  if(isDefined(var_2))
    wait(var_2);
  else
    wait(var_7);

  if(isDefined(var_3.col_brush))
    var_3.col_brush connectpaths();

  if(isDefined(var_2) && var_2 < var_7)
    wait(var_7 - var_2);

  wait 0.05;

  if(isDefined(var_6))
    var_4 rotateyaw(var_6, 2.5, 0.05, 2.45);
}

close_gate(var_0, var_1, var_2) {
  self moveto(var_0, var_1);

  if(isDefined(var_2))
    wait(var_2);
  else
    wait(var_1);

  self.col_brush disconnectpaths();
}

open_gate(var_0, var_1, var_2) {
  self moveto(var_0, var_1);

  if(isDefined(var_2))
    wait(var_2);
  else
    wait(var_1);

  self.col_brush connectpaths();
}

vision_hit_transition(var_0, var_1, var_2, var_3, var_4) {
  thread maps\_utility::vision_set_fog_changes(var_0, var_2);
  wait(var_2);
  wait(var_3);
  thread maps\_utility::vision_set_fog_changes(var_1, var_4);
  wait(var_4);
}

vision_watcher(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.flag[var_0]))
    common_scripts\utility::flag_init(var_0);

  if(!isDefined(level._vision_sets_active))
    level._vision_sets_active = 0;

  thread vision_watcher_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

vision_watcher_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_7))
    level endon(var_7);

  var_8 = 0;

  for(;;) {
    if(common_scripts\utility::flag(var_0) && !var_8) {
      maps\_utility::vision_set_fog_changes(var_1, var_2);

      if(isDefined(var_5))
        thread[[var_5]]();

      var_8 = 1;
      level._vision_sets_active++;
    } else if(!common_scripts\utility::flag(var_0) && var_8) {
      if(level._vision_sets_active == 1)
        maps\_utility::vision_set_fog_changes(var_3, var_4);

      if(isDefined(var_6))
        thread[[var_6]]();

      var_8 = 0;
      level._vision_sets_active--;
    }

    wait 0.05;
  }
}

flag_watcher(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    level endon(var_3);

  if(!common_scripts\utility::flag_exist(var_0))
    common_scripts\utility::flag_init(var_0);

  var_4 = 0;

  for(;;) {
    if(common_scripts\utility::flag(var_0) && !var_4) {
      if(isDefined(var_1))
        thread[[var_1]]();

      var_4 = 1;
    } else if(!common_scripts\utility::flag(var_0) && var_4) {
      if(isDefined(var_2))
        thread[[var_2]]();

      var_4 = 0;
    }

    wait 0.05;
  }
}

real_reload() {
  self endon("death");

  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();
    var_1 = self getcurrentweaponclipammo();
    thread real_reload_proc(var_0, var_1);
  }
}

real_reload_proc(var_0, var_1) {
  self endon("death");
  self endon("weapon_fire");
  self endon("weapon_change");
  self endon("weapon_dropped");
  self waittill("reload");

  if(var_0 == self getcurrentweapon() && var_1 != self getcurrentweaponclipammo()) {
    var_2 = self getweaponammostock(var_0);
    self setweaponammostock(var_0, var_2 - var_1);
  }
}

black_ice_geyser_pulse() {
  var_0 = getEntArray("firegeyser_flicker", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(maps\_utility::is_gen4()) {
      var_0[var_1] thread flicker(0.3, 1.0, "notify_stop_flicker");
      continue;
    }

    var_0[var_1] thread flicker();
  }
}

black_ice_geyser2_pulse() {
  var_0 = getEntArray("blackice_flicker2", "script_noteworthy");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(maps\_utility::is_gen4()) {
      var_0[var_1] thread flicker(0.3, 1.0, "notify_stop_flicker");
      continue;
    }

    var_0[var_1] thread flicker();
  }
}

flicker(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 0.2;

  if(var_0 > 0.999)
    var_0 = 0.999;

  if(!isDefined(var_1))
    var_1 = 1.0;

  self endon("notify_stop_flicker");

  if(maps\_utility::is_gen4())
    thread jittermove(10, 0.2, 0.1);
  else
    thread jittermove(3.5, 0.2, 0.1);

  var_4 = [0.1, 0.05, 0.1, 0.05, 0.25, 0.05, 0.075, 0.05, 0.15, 0.075];
  var_5 = [0.0, 0.25, 0.5, 0.4, 0.05, 0.45, 1.0, 0.25, 0.02, 0.75];

  if(!isDefined(var_3))
    var_3 = self getlightintensity();

  var_6 = 0;

  for(;;) {
    self setlightintensity(var_3 * (1 - var_0 * var_5[var_6]));
    wait(var_4[var_6] * var_1);
    var_6 = var_6 + 1;

    if(var_6 == var_4.size)
      var_6 = 0;
  }
}

jittermove(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 2.0;

  var_3 = 1.0;

  if(!isDefined(var_1))
    var_1 = 0.25;

  if(!isDefined(var_2))
    var_2 = 0.1;

  var_4 = self.origin;

  for(;;) {
    var_5 = var_4 + common_scripts\utility::randomvectorrange(var_3, var_0);
    var_6 = randomfloatrange(var_2, var_1);
    self moveto(var_5, var_6);
    wait(var_6);
    self moveto(var_4, 0.1);
    wait 0.1;
  }
}

rotatelights(var_0, var_1, var_2) {
  var_3 = getEntArray(var_1, "targetname");
  var_4 = getent(var_0, "targetname");
  var_4 thread rotateme(-360, var_2);

  foreach(var_6 in var_3)
  var_6 thread maps\_utility::manual_linkto(var_4, var_6.origin - var_4.origin);
}

rotateme(var_0, var_1) {
  for(;;) {
    switch (var_1) {
      case "yaw":
        self rotateyaw(var_0, 1);
        wait 1;
        break;
      case "pitch":
        self rotatepitch(var_0, 1);
        wait 1;
        break;
      case "roll":
        self rotateroll(var_0, 1);
        wait 1;
        break;
      default:
        wait 1;
        break;
    }
  }
}

god_rays_from_world_location(var_0, var_1, var_2, var_3, var_4) {
  if(maps\_utility::is_gen4()) {
    if(isDefined(var_1))
      common_scripts\utility::flag_wait(var_1);

    var_5 = 0;
    var_6 = 0;

    if(isDefined(var_3))
      maps\_utility::vision_set_fog_changes(var_3, 5);

    var_7 = maps\_utility::create_sunflare_setting("default");

    for(;;) {
      var_5 = atan((level.player.origin[2] - var_0[2]) / sqrt(squared(level.player.origin[0] - var_0[0]) + squared(level.player.origin[1] - var_0[1])));

      if(level.player.origin[0] < var_0[0])
        var_6 = atan((level.player.origin[1] - var_0[1]) / (level.player.origin[0] - var_0[0]));
      else
        var_6 = 180 + atan((level.player.origin[1] - var_0[1]) / (level.player.origin[0] - var_0[0]));

      var_7.position = (var_5, var_6, 0);
      maps\_art::sunflare_changes("default", 0);
      wait 0.05;

      if(isDefined(var_2)) {
        if(common_scripts\utility::flag(var_2)) {
          break;
        }
      }
    }

    if(isDefined(var_4)) {
      maps\_utility::vision_set_fog_changes(var_4, 5);
      wait 5;
      maps\_utility::vision_set_fog_changes("", 1);
    }
  }
}

set_forcesuppression(var_0) {
  if(var_0)
    self.forcesuppression = 1;
  else
    self.forcesuppression = 0;
}

push_player_impulse(var_0, var_1, var_2) {
  var_3 = var_2;
  var_0 = var_0 * var_1;

  for(var_4 = var_0; var_3 > 0.0; var_3 = var_3 - level.timestep) {
    var_5 = normalize_value(0, var_2, var_3);
    var_0 = var_4 * var_5;
    level.player pushplayervector(var_0);
    wait(level.timestep);
  }

  var_0 = (0, 0, 0);
  level.player pushplayervector(var_0);
}

player_view_shake_blender(var_0, var_1, var_2) {
  for(var_3 = var_0; var_3 > 0; var_3 = var_3 - level.timestep) {
    var_4 = normalize_value(0, var_0, var_3);
    var_5 = factor_value_min_max(var_2, var_1, var_4);
    earthquake(var_5, 0.2, level.player.origin, 100000.0);
    wait(level.timestep);
  }
}

debug_pos_3d(var_0) {
  self endon("stop_print3d");
  self endon("death");
  var_1 = "(.)";

  if(isDefined(var_0))
    var_1 = var_0;

  for(;;)
    wait 0.05;
}

ally_cqb_kill(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_ally_cqb_kill");

  if(isDefined(var_4))
    level endon(var_4);

  maps\_utility::enable_cqbwalk();

  while(level._enemies[var_0].size == 0)
    wait 0.05;

  var_5 = 192;
  var_6 = maps\_utility::remove_dead_from_array(level._enemies[var_0]);

  if(var_6.size == 0) {
    return;
  }
  var_6 = sortbydistance(var_6, self.origin);

  if(isDefined(var_1))
    var_5 = var_1;

  if(!isDefined(var_2))
    var_2 = var_6.size;

  if(var_2 > var_6.size)
    var_2 = var_6.size;

  for(var_7 = 0; var_7 < var_2; var_7++) {
    ally_cqb_kill_solo(var_6[var_7], var_5, var_3);
    wait 0.05;
  }
}

ally_cqb_kill_solo(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("kill");

  while(isalive(var_0)) {
    var_3 = 0;
    var_4 = undefined;
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4.origin = var_0 gettagorigin("j_head");
    var_4 linkto(var_0);

    if(animscripts\utility::canseeandshootpoint(var_4.origin)) {
      var_3 = 1;
      maps\_utility::cqb_aim(var_4);
      wait 0.5;
    }

    if(isDefined(var_2) && var_2) {
      while(!level.player maps\_utility::player_looking_at(var_0.origin))
        wait 0.05;
    }

    var_5 = distancesquared(self.origin, var_0.origin);

    if(var_5 <= var_1 * var_1) {
      if(var_3) {
        self shoot(1000, var_4.origin);
        var_0 maps\black_ice_vignette::vignette_kill();
        break;
      }
    }

    wait 0.05;
    var_4 delete();
  }
}

cover_left_idle(var_0) {
  var_1 = self;

  if(isDefined(var_0)) {
    var_2 = getnode(var_0, "targetname");
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = var_2.origin;
    var_1.angles = vectortoangles(anglestoright(var_2.angles));
    thread idle_cleanup(var_1);
  }

  var_1 thread maps\_anim::anim_loop_solo(self, "cover_left_idle");
}

idle_cleanup(var_0) {
  self waittill("stop_loop");
  var_0 notify("stop_loop");
  var_0 delete();
}

waittill_trigger_activate_looking_at(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0.5;

  if(isDefined(var_3))
    var_7 = var_3;

  var_8 = 64;

  if(isDefined(var_2))
    var_8 = var_2;

  var_9 = var_0;

  if(isDefined(var_4)) {
    var_9 = var_0 common_scripts\utility::spawn_tag_origin();
    var_9 linkto(var_0, var_4, (0, 0, 0), (0, 0, 0));
  }

  if(!isDefined(var_5))
    var_5 = 5;

  var_10 = var_1;

  if(!common_scripts\utility::flag_exist(var_10))
    common_scripts\utility::flag_init(var_10);

  var_11 = 0;
  var_12 = 0;

  for(;;) {
    if(level.player ismeleeing() || level.player isthrowinggrenade() || !level.player isonground() || level.player getstance() == "prone") {
      common_scripts\utility::flag_clear(var_10);
      var_12 = 0;
      level.player enableweaponpickup();
    } else if(level.player maps\_utility::player_looking_at(var_9.origin, var_7, 1)) {
      if(isDefined(var_6)) {
        if(common_scripts\utility::flag(var_6)) {
          if(!common_scripts\utility::flag(var_10))
            var_11 = 1;
        } else {
          common_scripts\utility::flag_clear(var_10);
          var_12 = 0;
          level.player enableweaponpickup();
        }
      } else if(distance(level.player getEye(), var_9.origin) <= var_8) {
        if(!common_scripts\utility::flag(var_10))
          var_11 = 1;
      } else {
        common_scripts\utility::flag_clear(var_10);
        var_12 = 0;
        level.player enableweaponpickup();
      }
    } else {
      common_scripts\utility::flag_clear(var_10);
      var_12 = 0;
      level.player enableweaponpickup();
    }

    if(level.player useButtonPressed())
      var_12++;

    if(common_scripts\utility::flag(var_10) && var_12 >= var_5) {
      break;
    }

    if(var_11) {
      common_scripts\utility::flag_set(var_10);
      maps\_utility::display_hint_timeout(var_1);
      var_11 = 0;
      level.player disableweaponpickup();
    }

    wait 0.05;
  }

  level.player enableweaponpickup();
  common_scripts\utility::flag_clear(var_10);

  if(isDefined(var_4))
    var_9 delete();
}

setup_tag_anim_rig(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 3;

  var_4 = getent(var_0, "script_noteworthy");
  var_4.anim_node = common_scripts\utility::spawn_tag_origin();
  var_4.anim_node.origin = var_4.origin;
  var_4.anim_node.angles = var_4.angles;
  var_4 maps\_utility::assign_animtree(var_1);
  var_0 = var_4.model;
  var_5 = getnumparts(var_0);

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = getpartname(var_0, var_6);

    if(getsubstr(var_7, 0, 4) == "mdl_") {
      var_8 = getsubstr(var_7, 4, var_7.size - var_2);
      var_9 = spawn("script_model", var_4 gettagorigin(var_7));
      var_9 setModel(var_8);
      var_9.angles = var_4 gettagangles(var_7);
      var_9 linkto(var_4, var_7);

      if(isDefined(var_3) && var_3) {
        var_9.coll = "coll_" + getsubstr(var_7, 4, var_7.size);
        level.tag_anim_rig_models[level.tag_anim_rig_models.size] = var_9;
      }
    }
  }

  return var_4;
}

tag_anim_rig_init_and_flag_wait(var_0, var_1) {
  if(!common_scripts\utility::flag_exist(var_0))
    common_scripts\utility::flag_init(var_0);

  self.anim_node maps\_anim::anim_first_frame_solo(self, var_1);
  common_scripts\utility::flag_wait(var_0);
  self.anim_node maps\_anim::anim_single_solo(self, var_1);
}

waittill_trigger(var_0) {
  self waittill("trigger");
  level notify(var_0);
}

start_point_is_after(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_0 = tolower(var_0);
  var_4 = getarraykeys(level.start_arrays);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] == var_0)
      var_2 = var_5;

    if(var_4[var_5] == level.start_point)
      var_3 = var_5;
  }

  if(isDefined(var_1) && var_1) {
    if(var_3 >= var_2)
      return 1;
  } else if(var_3 > var_2)
    return 1;

  return 0;
}

start_point_is_before(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_0 = tolower(var_0);
  var_4 = getarraykeys(level.start_arrays);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] == var_0)
      var_2 = var_5;

    if(var_4[var_5] == level.start_point)
      var_3 = var_5;
  }

  if(isDefined(var_1) && var_1) {
    if(var_3 <= var_2)
      return 1;
  } else if(var_3 < var_2)
    return 1;

  return 0;
}

setup_player_for_animated_sequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0) {
    if(!isDefined(var_1))
      var_1 = 60;
  }

  if(!isDefined(var_2))
    var_2 = level.player.origin;

  if(!isDefined(var_3))
    var_3 = level.player.angles;

  if(!isDefined(var_4))
    var_4 = 1;

  var_7 = maps\_utility::spawn_anim_model("player_rig", var_2);
  level.player_rig = var_7;
  var_7.angles = var_3;
  var_7.animname = "player_rig";

  if(isDefined(var_6))
    var_8 = maps\_utility::spawn_anim_model(var_6);
  else
    var_8 = common_scripts\utility::spawn_tag_origin();

  level.player_mover = var_8;
  var_8.origin = var_2;
  var_8.angles = var_3;
  var_7 linkto(var_8);

  if(var_0)
    level.player playerlinktodelta(var_7, "tag_player", 1, var_1, var_1, var_1, var_1, 1);

  if(var_4)
    thread player_animated_sequence_restrictions(var_5);
}

player_animated_sequence_restrictions(var_0) {
  if(isDefined(var_0) && var_0)
    level.player waittill("notify_player_animated_sequence_restrictions");

  level.player.disablereload = 1;
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player disableweaponswitch();
  level.player allowcrouch(0);
  level.player allowjump(0);
  level.player allowmelee(0);
  level.player allowprone(0);
  level.player allowsprint(0);
}

player_animated_sequence_cleanup() {
  if(!isDefined(level.player.early_weapon_enabled) || !level.player.early_weapon_enabled) {
    level.player.early_weapon_enabled = undefined;
    level.player.disablereload = 0;
    level.player enableweapons();
    level.player enableoffhandweapons();
    level.player enableweaponswitch();
  }

  level.player allowcrouch(1);
  level.player allowjump(1);
  level.player allowmelee(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player unlink();

  if(isDefined(level.player_mover))
    level.player_mover delete();

  if(isDefined(level.player_rig))
    level.player_rig delete();
}

get_rumble_ent_linked(var_0, var_1) {
  if(maps\_utility::is_coop()) {}

  var_2 = maps\_utility::get_player_from_self();

  if(!isDefined(var_1))
    var_1 = "steady_rumble";

  var_3 = spawn("script_origin", var_0.origin);
  var_3.intensity = 1;
  var_3 thread update_rumble_intensity_linked(var_2, var_1, var_0);
  return var_3;
}

update_rumble_intensity_linked(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 0;

  for(;;) {
    if(self.intensity > 0.0001 && gettime() > 300) {
      if(!var_3) {
        self playrumblelooponentity(var_1);
        var_3 = 1;
      }
    } else if(var_3) {
      self stoprumble(var_1);
      var_3 = 0;
    }

    var_4 = 1 - self.intensity;
    var_4 = var_4 * 1000;
    self.origin = var_2.origin + (0, 0, var_4);
    wait 0.05;
  }
}

ally_catchup(var_0, var_1, var_2) {
  common_scripts\utility::array_thread(var_0, ::ally_catchup_solo, var_1, var_2, self);
}

ally_catchup_solo(var_0, var_1, var_2) {
  self notify("notify_ally_catchup_stop");
  self endon("notify_ally_catchup_stop");
  var_3 = 400;
  var_4 = 600;

  if(isDefined(var_0))
    var_3 = var_0;

  if(isDefined(var_1))
    var_4 = var_1;

  var_5 = getallnodes();

  if(isDefined(var_2) && isDefined(var_2.target)) {
    var_6 = getent(var_2.target, "targetname");
    var_7 = var_5;
    var_5 = [];

    foreach(var_9 in var_5) {
      if(var_9.type == "Path" && var_9 istouching(var_6))
        var_5 = common_scripts\utility::array_add(var_5, var_9);
    }
  }

  while(distance(self.origin, level.player.origin) > var_3) {
    if(!level.player maps\_utility::player_looking_at(self.origin, 0.1, 1)) {
      foreach(var_9 in var_5) {
        if(issubstr(var_9.type, "Path") && distance(var_9.origin, level.player.origin) <= var_4 && distance(var_9.origin, level.player.origin) >= var_3 && abs(var_9.origin[2] - level.player.origin[2] < 10) && !level.player maps\_utility::player_looking_at(var_9.origin, 0.1, 1)) {
          self forceteleport(var_9.origin, vectortoangles(level.player.origin - var_9.origin));
          break;
        }
      }
    }

    wait 0.05;
  }
}

deathfunc_grenade_drop() {
  maps\_spawner::waittilldeathorpaindeath();

  if(!isDefined(self)) {
    return;
  }
  if(self.grenadeammo > 0) {
    return;
  }
  if(isDefined(self.nodrop)) {
    return;
  }
  level.nextgrenadedrop--;

  if(level.nextgrenadedrop > 0) {
    return;
  }
  level.nextgrenadedrop = 2 + randomint(2);
  var_0 = 25;
  var_1 = 12;
  var_2 = self.origin + (randomint(var_0) - var_1, randomint(var_0) - var_1, 2) + (0, 0, 42);
  var_3 = (0, randomint(360), 90);
  thread maps\_spawner::spawn_grenade_bag(var_2, var_3, self.team);
}

waittill_notify_flag_set(var_0, var_1) {
  if(!common_scripts\utility::flag_exist(var_1))
    common_scripts\utility::flag_init(var_1);

  self waittill(var_0);
  common_scripts\utility::flag_set(var_1);
}

flag_wait_func(var_0, var_1, var_2) {
  common_scripts\utility::flag_wait(var_0);

  if(isDefined(var_2))
    self[[var_1]](var_2);
  else
    self[[var_1]]();
}

waittill_notify_func(var_0, var_1, var_2, var_3) {
  self waittill(var_0);

  if(isDefined(var_3))
    self[[var_1]](var_2, var_3);
  else if(isDefined(var_2))
    self[[var_1]](var_2);
  else
    self[[var_1]]();
}

black_ice_hide_hud() {
  level.black_ice_hud = 1;
  level.black_ice_hud_ammocounterhide = getdvarint("ammoCounterHide");
  level.black_ice_hud_actionslotshide = getdvarint("actionSlotsHide");
  level.black_ice_hud_showstance = getdvarint("hud_showStance");
  level.black_ice_hud_compass = getdvarint("compass");
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("compass", 0);
}

black_ice_show_previous_hud() {
  if(!isDefined(level.black_ice_hud)) {
    return;
  }
  setsaveddvar("ammoCounterHide", level.black_ice_hud_ammocounterhide);
  setsaveddvar("actionSlotsHide", level.black_ice_hud_actionslotshide);
  setsaveddvar("hud_showStance", level.black_ice_hud_showstance);
  setsaveddvar("compass", level.black_ice_hud_compass);
  level.black_ice_hud = undefined;
  level.black_ice_hud_ammocounterhide = undefined;
  level.black_ice_hud_actionslotshide = undefined;
  level.black_ice_hud_showstance = undefined;
  level.black_ice_hud_compass = undefined;
}