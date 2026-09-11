/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_vip.gsc
***********************************************/

function vip_spawn(var0, var1, var2) {
  jumpiffalse(istrue(var1)) LOC_00000017;
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "vip_spawn");

  for(;;) {
    if(scripts\cp\cp_modular_spawning::allowed_to_spawn_agent(undefined, 1, 1, var2)) {
      var3 = scripts\mp\mp_agent::spawnnewagentaitype("actor_civilian_cp_pilot_hvt", var0.origin, var0.angles);

      if(isDefined(var3)) {
        var3 scripts\cp\cp_modular_spawning::update_spawn_data_on_spawn();
        var3 thread scripts\cp\cp_modular_spawning::_update_spawn_data_on_death();
        break;
      }
    }

    wait 0.1;
  }

  if(istrue(var1)) {
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "vip_spawn");
  }

  var3.scripted_mode = 1;
  var3.ignoreall = 1;
  var3.dontkilloff = 1;
  var3.health = 100000;
  var3.maxhealth = 100000;
  var3.suppressionthreshold = 0;
  var3.meleealwasywin = 1;
  var3.dontmeleeme = 1;
  var3.dontmelee = 1;
  set_default_vip_hints(var3);
  return var3;
}

function set_default_vip_hints(var0) {
  if(!isDefined(var0.hint_use)) {
    var0.hint_use = &"CP_BR_SYRK_OBJECTIVES/USE_VIP";
  }

  if(!isDefined(var0.hint_stop)) {
    var0.hint_stop = &"CP_BR_SYRK_OBJECTIVES/STOP_USE_VIP";
    return;
  }
}

function set_vip_hints(var0, var1, var2) {
  if(!isDefined(var0.followingplayer)) {
    if(isDefined(var2)) {
      var0.hint_stop = var2;
    }

    var0.trigger setHintString(var0.hint_stop);
    return;
  }

  if(isDefined(var1)) {
    var0.hint_use = var1;
  }

  var0.trigger setHintString(var0.hint_use);
}

function create_vip_trigger(var0, var1) {
  set_default_vip_hints(var0);
  var0.trigger = spawn("script_model", var0.origin + (0, 0, 30));
  var0.trigger linkTo(var0);
  var0.onuse = &vip_onuse;
  var0.trigger setHintString(var0.hint_use);
  var0.trigger setCursorHint("HINT_BUTTON");
  var0.trigger sethintdisplayrange(148);
  var0.trigger sethintdisplayfov(90);
  var0.trigger setuserange(72);
  var0.trigger setusefov(45);
  var0.trigger sethintonobstruction("show");
  var0.trigger sethintrequiresholding(1);
  var0.trigger setuseholdduration("duration_short");
  var0 thread scripts\engine\utility::delete_on_death(var0.trigger);
  thread vip_use_think(var0, var0);
}

function vip_use_think(var0, var1) {
  var0 endon("death");
  var0 endon("downed");
  var0 endon("exfil");
  var0.trigger endon("death");

  for(;;) {
    var0.trigger waittill("trigger", var2);

    if(!var2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var0[[var0.onuse]](var2, var1);
  }
}

function vip_turnoff(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isalive(var0)) {
    return;
  }

  var0 notify("exfil");
  var0 notify("stop_vip_follow");
  stop_following_all_players(var0);

  if(isDefined(var0.trigger)) {
    var0.trigger delete();
    return;
  }
}

function update_vip_trigger(var0, var1, var2) {
  self.trigger endon("death");
  self.trigger makeunusable();
  wait 2;
  self.trigger setHintString(var0);
  self.trigger makeusable();
}

function vip_onuse(var0, var1) {
  self notify("vip_used");
  set_default_vip_hints(self);

  if(!isDefined(self.followingplayer)) {
    if(istrue(var1)) {
      self.headicon = deleteheadicon(self);
      setheadiconfriendlyimage(self.headicon, "hud_icon_esc_bounty_target");
      setheadicondrawthroughgeo(self.headicon, 1);
      setheadiconsnaptoedges(self.headicon, 29000);
      setheadiconmaxdistance(self.headicon, 10);
      addclienttoheadiconmask(self.headicon, 10);
    }

    enable_outline();
    thread remove_headicon_on_death();
    thread vip_followplayer(var0);
    thread update_vip_trigger(self.hint_stop, 1, var0);
    return;
  }

  self notify("stop_vip_follow");
  self notify("remove_headicon");
  disable_outline();
  self.followingplayer = undefined;
  var2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var2);
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
    self waittill("damage", var0, var1);

    if(!istrue(self.bledout)) {
      self.health = self.maxhealth;
    }

    if(isDefined(var1) && var1.team == self.team) {
      continue;
    }

    self.script_health -= var0;

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

function revive_vip(var0, var1) {
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
  thread update_vip_trigger(self.hint_stop, 1, var0);
  self.trigger setuseholdduration("duration_short");
  enable_outline();
  thread vip_followplayer(var0);
  objective_icon(self.objnum, "icon_waypoint_objective_general");
  self notify("revive");
  self notify("revived");
  self.onuse = &vip_onuse;
}

function vip_followplayer(var0) {
  self endon("game_ended");
  self endon("death");
  self notify("stop_vip_follow");
  self endon("stop_vip_follow");
  self.goalradius = 128;
  self.followingplayer = var0;
  var1 = squared(256);

  while(var0 scripts\cp\utility::is_valid_player(1)) {
    if(distancesquared(var0.origin, self.origin) > var1) {
      var2 = getclosestpointonnavmesh(var0.origin);
      self setgoalpos(var2);
    }

    wait 1;
  }

  var3 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(var3)) {
    self.followingplayer = undefined;
    vip_onuse(var3, 0);
    return;
  }

  stop_following_all_players();
}

function stop_following_all_players() {
  set_default_vip_hints(self);
  self notify("remove_headicon");
  disable_outline();
  self.followingplayer = undefined;
  var0 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var0);
  thread update_vip_trigger(self.hint_use, 0);
}

function remove_headicon_on_death() {
  if(!isDefined(self.headicon)) {
    return;
  }

  var0 = self.headicon;
  var1 = scripts\engine\utility::ref_143a5("death", "remove_headicon");
  setheadiconimage(var0);
}

function enable_outline() {
  self hudoutlineenable("outline_nodepth_cyan");
}

function disable_outline() {
  self hudoutlinedisable();
}