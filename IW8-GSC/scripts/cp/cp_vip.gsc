/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_vip.gsc
***********************************************/

function vip_spawn(var_0, var_1, var_2) {
  jumpiffalse(istrue(var_1)) LOC_00000017;
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "vip_spawn");

  for(;;) {
    if(scripts\cp\cp_modular_spawning::allowed_to_spawn_agent(undefined, 1, 1, var_2)) {
      var_3 = scripts\mp\mp_agent::spawnnewagentaitype("actor_civilian_cp_pilot_hvt", var_0.origin, var_0.angles);

      if(isDefined(var_3)) {
        var_3 scripts\cp\cp_modular_spawning::update_spawn_data_on_spawn();
        var_3 thread scripts\cp\cp_modular_spawning::_update_spawn_data_on_death();
        break;
      }
    }

    wait 0.1;
  }

  if(istrue(var_1)) {
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "vip_spawn");
  }

  var_3.scripted_mode = 1;
  var_3.ignoreall = 1;
  var_3.dontkilloff = 1;
  var_3.health = 100000;
  var_3.maxhealth = 100000;
  var_3.suppressionthreshold = 0;
  var_3.meleealwasywin = 1;
  var_3.dontmeleeme = 1;
  var_3.dontmelee = 1;
  set_default_vip_hints(var_3);
  return var_3;
}

function set_default_vip_hints(var_0) {
  if(!isDefined(var_0.hint_use)) {
    var_0.hint_use = &"CP_BR_SYRK_OBJECTIVES/USE_VIP";
  }

  if(!isDefined(var_0.hint_stop)) {
    var_0.hint_stop = &"CP_BR_SYRK_OBJECTIVES/STOP_USE_VIP";
    return;
  }
}

function set_vip_hints(var_0, var_1, var_2) {
  if(!isDefined(var_0.followingplayer)) {
    if(isDefined(var_2)) {
      var_0.hint_stop = var_2;
    }

    var_0.trigger setHintString(var_0.hint_stop);
    return;
  }

  if(isDefined(var_1)) {
    var_0.hint_use = var_1;
  }

  var_0.trigger setHintString(var_0.hint_use);
}

function create_vip_trigger(var_0, var_1) {
  set_default_vip_hints(var_0);
  var_0.trigger = spawn("script_model", var_0.origin + (0, 0, 30));
  var_0.trigger linkTo(var_0);
  var_0.onuse = &vip_onuse;
  var_0.trigger setHintString(var_0.hint_use);
  var_0.trigger setCursorHint("HINT_BUTTON");
  var_0.trigger sethintdisplayrange(148);
  var_0.trigger sethintdisplayfov(90);
  var_0.trigger setuserange(72);
  var_0.trigger setusefov(45);
  var_0.trigger sethintonobstruction("show");
  var_0.trigger sethintrequiresholding(1);
  var_0.trigger setuseholdduration("duration_short");
  var_0 thread scripts\engine\utility::delete_on_death(var_0.trigger);
  thread vip_use_think(var_0, var_0);
}

function vip_use_think(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("downed");
  var_0 endon("exfil");
  var_0.trigger endon("death");

  for(;;) {
    var_0.trigger waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var_0[[var_0.onuse]](var_2, var_1);
  }
}

function vip_turnoff(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isalive(var_0)) {
    return;
  }

  var_0 notify("exfil");
  var_0 notify("stop_vip_follow");
  stop_following_all_players(var_0);

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
    return;
  }
}

function update_vip_trigger(var_0, var_1, var_2) {
  self.trigger endon("death");
  self.trigger makeunusable();
  wait 2;
  self.trigger setHintString(var_0);
  self.trigger makeusable();
}

function vip_onuse(var_0, var_1) {
  self notify("vip_used");
  set_default_vip_hints(self);

  if(!isDefined(self.followingplayer)) {
    if(istrue(var_1)) {
      self.headicon = deleteheadicon(self);
      setheadiconfriendlyimage(self.headicon, "hud_icon_esc_bounty_target");
      setheadicondrawthroughgeo(self.headicon, 1);
      setheadiconsnaptoedges(self.headicon, 29000);
      setheadiconmaxdistance(self.headicon, 10);
      addclienttoheadiconmask(self.headicon, 10);
    }

    enable_outline();
    thread remove_headicon_on_death();
    thread vip_followplayer(var_0);
    thread update_vip_trigger(self.hint_stop, 1, var_0);
    return;
  }

  self notify("stop_vip_follow");
  self notify("remove_headicon");
  disable_outline();
  self.followingplayer = undefined;
  var_2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_2);
  thread update_vip_trigger(self.hint_use, 0);
}

function vip_damage_monitor() {
  self endon("death");
  self endon("rescued");
  objective_setlabel(self.objnum, &"CP_BR_SYRK_OBJECTIVES/PILOT_HEALTH");
  self.script_health = 100;
  self.health = 10000;
  self.maxhealth = 10000;
  objective_setprogress(self.objnum, 0.99);

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!istrue(self.bledout)) {
      self.health = self.maxhealth;
    }

    if(isDefined(var_1) && var_1.team == self.team) {
      continue;
    }

    self.script_health -= var_0;

    if(self.script_health < 0) {
      self.script_health = 0;
    }

    objective_setprogress(self.objnum, self.script_health / 100);

    if(self.script_health <= 0) {
      thread ai_enter_laststand();
      self waittill("revived");
    }
  }
}

function ai_enter_laststand() {
  self endon("death");
  self endon("revived");
  self setCanDamage(0);
  self.trigger setHintString(&"COOP_GAME_PLAY/REVIVE_USE");
  self.trigger setuseholdduration("duration_long");
  self.onuse = &revive_vip;
  self notify("stop_vip_follow");
  self.reviveiconent = spawn("script_origin", self.trigger.origin);
  scripts\cp\cp_laststand::makereviveicon(self.reviveiconent, self, (1, 1, 1), 30);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self setlookatentity();
  self.headlook_enabled = 0;
  self.disableautolookat = 1;
  scripts\asm\shared\mp\utility::burndowntime("idle_to_laststand");
  scripts\asm\shared\mp\utility::bunkernum("laststand_idle", 30);

  if(isDefined(self.reviveiconent)) {
    self.reviveiconent delete();
  }

  self.bledout = 1;
  self dodamage(self.health + 100, self.origin);
}

function revive_vip(var_0, var_1) {
  if(isDefined(self.reviveiconent)) {
    self.reviveiconent delete();
  }

  scripts\asm\shared\mp\utility::burndowntime("laststand_to_idle");
  scripts\cp\cp_skits::reset_guy(self);
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.script_health = 100;
  self.inlaststand = 0;
  objective_setprogress(self.objnum, 0.99);
  thread update_vip_trigger(self.hint_stop, 1, var_0);
  self.trigger setuseholdduration("duration_short");
  enable_outline();
  thread vip_followplayer(var_0);
  objective_icon(self.objnum, "icon_waypoint_objective_general");
  self notify("revive");
  self notify("revived");
  self.onuse = &vip_onuse;
}

function vip_followplayer(var_0) {
  self endon("game_ended");
  self endon("death");
  self notify("stop_vip_follow");
  self endon("stop_vip_follow");
  self.goalradius = 128;
  self.followingplayer = var_0;
  var_1 = squared(256);

  while(var_0 scripts\cp\utility::is_valid_player(1)) {
    if(distancesquared(var_0.origin, self.origin) > var_1) {
      var_2 = getclosestpointonnavmesh(var_0.origin);
      self setgoalpos(var_2);
    }

    wait 1;
  }

  var_3 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(var_3)) {
    self.followingplayer = undefined;
    vip_onuse(var_3, 0);
    return;
  }

  stop_following_all_players();
}

function stop_following_all_players() {
  set_default_vip_hints(self);
  self notify("remove_headicon");
  disable_outline();
  self.followingplayer = undefined;
  var_0 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_0);
  thread update_vip_trigger(self.hint_use, 0);
}

function remove_headicon_on_death() {
  if(!isDefined(self.headicon)) {
    return;
  }

  var_0 = self.headicon;
  var_1 = scripts\engine\utility::ref_143A5("death", "remove_headicon");
  setheadiconimage(var_0);
}

function enable_outline() {
  self hudoutlineenable("outline_nodepth_cyan");
}

function disable_outline() {
  self hudoutlinedisable();
}