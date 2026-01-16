/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_callbackglobal.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_music;
#include maps\_load_common;
#include maps\_empgrenade;
#include maps\_flashgrenades;
#include maps\_utility_code;
#include maps\_damagefeedback;
#include maps\_dds;
#include maps\_friendlyfire;
#include animscripts\balcony;
#include maps\_weapons;
#include maps\_laststand;
#include maps\_vehicle;
#include maps\_introscreen;

init() {
  level.splitscreen = issplitscreen();
  level.xenon = getdvar(#"xenonGame") == "true";
  level.ps3 = getdvar(#"ps3Game") == "true";
  level.wiiu = getdvar(#"wiiuGame") == "true";
  level.onlinegame = sessionmodeisonlinegame();
  level.systemlink = sessionmodeissystemlink();
  level.console = level.xenon || level.ps3 || level.wiiu;
  precachemenu("briefing");
  level.rankedmatch = level.onlinegame;
  level.profileloggedin = getdvar(#"xblive_loggedin") == "1";

  if(getdvarint(#"scr_forcerankedmatch") == 1)
    level.rankedmatch = 1;
}

setupcallbacks() {
  level.otherplayersspectate = 0;
  level.spawnplayer = ::spawnplayer;
  level.spawnclient = ::spawnclient;
  level.spawnspectator = ::spawnspectator;
  level.spawnintermission = ::spawnintermission;
  level.onspawnplayer = ::default_onspawnplayer;
  level.onpostspawnplayer = ::default_onpostspawnplayer;
  level.onspawnspectator = ::default_onspawnspectator;
  level.onspawnintermission = ::default_onspawnintermission;
  level.onstartgametype = ::blank;
  level.onplayerconnect = ::blank;
  level.onplayerdisconnect = ::blank;
  level.onplayerdamage = ::blank;
  level.onplayerkilled = ::blank;
  level.onplayerweaponswap = ::blank;
  level._callbacks["on_first_player_connect"] = [];
  level._callbacks["on_player_connect"] = [];
  level._callbacks["on_player_disconnect"] = [];
  level._callbacks["on_player_damage"] = [];
  level._callbacks["on_player_last_stand"] = [];
  level._callbacks["on_player_killed"] = [];
  level._callbacks["on_actor_damage"] = [];
  level._callbacks["on_actor_killed"] = [];
  level._callbacks["on_vehicle_damage"] = [];
  level._callbacks["on_save_restored"] = [];
}

addcallback(event, func) {
  assert(isDefined(event), "Trying to set a callback on an undefined event.");
  assert(isDefined(level._callbacks[event]), "Trying to set callback for unknown event '" + event + "'.");
  level._callbacks[event] = add_to_array(level._callbacks[event], func, 0);
}

removecallback(event, func) {
  assert(isDefined(event), "Trying to remove a callback on an undefined event.");
  assert(isDefined(level._callbacks[event]), "Trying to remove callback for unknown event '" + event + "'.");
  arrayremovevalue(level._callbacks[event], func, 1);
}

callback(event) {
  assert(isDefined(level._callbacks[event]), "Must init callback array before trying to call it.");

  for(i = 0; i < level._callbacks[event].size; i++) {
    callback = level._callbacks[event][i];

    if(isDefined(callback))
      self thread[[callback]]();
  }
}

blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) {
}

callback_curvenotify(string, curveid, nodeindex) {
  level notify(string, curveid, nodeindex);
}

callback_startgametype() {
}

checkpoint_invulnerability() {
  self endon("disconnect");
  self.checkpoint_invulnerability = 1;

  println("****checkpoint_invulnerability setting player involnerable for 3 sec****");

  wait 3;
  self.checkpoint_invulnerability = undefined;
}

callback_saverestored() {
  println("****Coop CodeCallback_SaveRestored****");

  players = get_players();
  level.debug_player = players[0];

  for(i = 0; i < 4; i++) {
    player = players[i];

    if(isDefined(player)) {
      player thread checkpoint_invulnerability();

      if(isDefined(player.savedvisionset))
        player visionsetnaked(player.savedvisionset, 0.1);

      dvarname = "player" + player getentitynumber() + "downs";
      player.downs = getdvarint(dvarname);
      player setclientdvar("hud_missionFailed", "0");
    }
  }

  level notify("save_restored");
  level callback("on_save_restored");
}

player_breadcrumb_reset(position, angles) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  level.playerprevorigin0 = position;
  level.playerprevorigin1 = position;

  if(!isDefined(level._player_breadcrumbs)) {
    level._player_breadcrumbs = [];

    for(i = 0; i < 4; i++) {
      level._player_breadcrumbs[i] = [];

      for(j = 0; j < 4; j++)
        level._player_breadcrumbs[i][j] = spawnstruct();
    }
  }

  for(i = 0; i < 4; i++) {
    for(j = 0; j < 4; j++) {
      level._player_breadcrumbs[i][j].pos = position;
      level._player_breadcrumbs[i][j].ang = angles;
    }
  }
}

player_breadcrumb_update() {
  self endon("disconnect");
  right = anglestoright(self.angles) * 70;
  level.playerprevorigin0 = self.origin + right;
  level.playerprevorigin1 = self.origin - right;

  if(!isDefined(level._player_breadcrumbs))
    player_breadcrumb_reset(self.origin, self.angles);

  num = self getentitynumber();

  while(true) {
    wait 1;
    dist_squared = distancesquared(self.origin, level.playerprevorigin0);

    if(dist_squared > 250000) {
      right = anglestoright(self.angles) * 70;
      level.playerprevorigin0 = self.origin + right;
      level.playerprevorigin1 = self.origin - right;
    } else if(dist_squared > 70 * 70) {
      level.playerprevorigin1 = level.playerprevorigin0;
      level.playerprevorigin0 = self.origin;
    }

    dist_squared = distancesquared(self.origin, level._player_breadcrumbs[num][0].pos);
    dropbreadcrumbs = 1;

    if(isDefined(level.flag) && isDefined(level.flag["drop_breadcrumbs"])) {
      if(!flag("drop_breadcrumbs"))
        dropbreadcrumbs = 0;
    }

    if(dropbreadcrumbs && dist_squared > 70 * 70) {
      for(i = 2; i >= 0; i--) {
        level._player_breadcrumbs[num][i + 1].pos = level._player_breadcrumbs[num][i].pos;
        level._player_breadcrumbs[num][i + 1].ang = level._player_breadcrumbs[num][i].ang;
      }

      level._player_breadcrumbs[num][0].pos = playerphysicstrace(self.origin, self.origin + vectorscale((0, 0, -1), 1000.0));
      level._player_breadcrumbs[num][0].ang = self.angles;
    }
  }
}

setplayerspawnpos() {
  players = get_players();
  player = players[0];

  if(!isDefined(level._player_breadcrumbs)) {
    spawnpoints = getentarray("info_player_deathmatch", "classname");

    if(player.origin == (0, 0, 0) && isDefined(spawnpoints) && spawnpoints.size > 0)
      player_breadcrumb_reset(spawnpoints[0].origin, spawnpoints[0].angles);
    else
      player_breadcrumb_reset(player.origin, player.angles);
  }

  spawn_pos = level._player_breadcrumbs[0][0].pos;
  dist_squared = distancesquared(player.origin, spawn_pos);

  if(dist_squared > 250000) {
    if(player.origin != (0, 0, 0))
      spawn_pos = player.origin + vectorscale((0, 1, 0), 30.0);
  } else if(dist_squared < 30 * 30)
    spawn_pos = level._player_breadcrumbs[0][1].pos;

  spawn_angles = vectornormalize(player.origin - spawn_pos);
  spawn_angles = vectortoangles(spawn_angles);

  if(!playerpositionvalid(spawn_pos)) {
    spawn_pos = player.origin;
    spawn_angles = player.angles;
  }

  self setorigin(spawn_pos);
  self setplayerangles(spawn_angles);
}

callback_playerconnect() {
  self thread player_connect();
  self waittill("begin");
  self reset_clientdvars();
  waittillframeend;
  wait 0.1;
  level notify("connected", self);
  self thread maps\_load_common::player_special_death_hint();
  self thread maps\_empgrenade::monitorempgrenade();
  self thread maps\_flashgrenades::monitorflash();
  info_player_spawn = getentarray("info_player_deathmatch", "classname");

  if(isDefined(info_player_spawn) && info_player_spawn.size > 0) {
    players = get_players("all");

    if(isDefined(players) && players.size != 0) {
      if(players[0] == self) {
        println("2:Setting player origin to info_player_start " + info_player_spawn[0].origin);

        self setorigin(info_player_spawn[0].origin);
        self setplayerangles(info_player_spawn[0].angles);
        self thread player_breadcrumb_update();
      } else {
        println("Callback_PlayerConnect:Setting player origin near host position " + players[0].origin);

        self setplayerspawnpos();
        self thread player_breadcrumb_update();
      }
    } else {
      println("Callback_PlayerConnect:Setting player origin to info_player_start " + info_player_spawn[0].origin);

      self setorigin(info_player_spawn[0].origin);
      self setplayerangles(info_player_spawn[0].angles);
      self thread player_breadcrumb_update();
    }
  }

  if(!isDefined(self.flag)) {
    self.flag = [];
    self.flags_lock = [];
  }

  if(!isDefined(self.flag["player_has_red_flashing_overlay"])) {
    self player_flag_init("player_has_red_flashing_overlay");
    self player_flag_init("player_is_invulnerable");
  }

  if(!isDefined(self.flag["loadout_given"]))
    self player_flag_init("loadout_given");

  self player_flag_clear("loadout_given");

  if(getdvar(#"r_reflectionProbeGenerate") == "1") {
    waittillframeend;
    self thread spawnplayer();
    return;
  }

  if(!isDefined(level.spawnclient)) {
    waittillframeend;
    self thread spawnplayer();
    return;
  }

  self setclientdvar("ui_allow_loadoutchange", "1");
  self setclientuivisibilityflag("hud_visible", 1);
  self thread[[level.spawnclient]]();
  dvarname = "player" + self getentitynumber() + "downs";
  setdvar(dvarname, self.downs);
}

reset_clientdvars() {
  if(isDefined(level.reset_clientdvars)) {
    self[[level.reset_clientdvars]]();
    return;
  }

  self setclientdvars("compass", "1", "hud_showStance", "1", "cg_cursorHints", "4", "hud_showobjectives", "1", "ammoCounterHide", "0", "miniscoreboardhide", "0", "ui_hud_hardcore", "0", "credits_active", "0", "hud_missionFailed", "0", "cg_cameraUseTagCamera", "1", "cg_drawCrosshair", "1", "r_heroLightScale", "1 1 1", "player_sprintUnlimited", "0", "r_bloomTweaks", "0", "r_exposureTweak", "0");
  self resetfov();
  self allowspectateteam("allies", 0);
  self allowspectateteam("axis", 0);
  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);
}

callback_playerdisconnect() {
  self callback("on_player_disconnect");
}

callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
  if(isDefined(self.checkpoint_invulnerability) && self.checkpoint_invulnerability && smeansofdeath != "MOD_FALLING") {
    println("*Callback_PlayerDamage: checkpoint protection enabled.");

    return;
  }

  if(self hasperk("specialty_armorvest") && !maps\_utility_code::isheaddamage(shitloc)) {
    assert(isDefined(level.cac_armorvest_data), "level.cac_armorvest_data value is missing. this is required for specialty_armorvest");
    idamage = int(idamage * (level.cac_armorvest_data * 0.01));

    if(getdvarint(#"_id_5ABA6445"))
      println("Perk--> Player took less bullet damage due to armorvest");

  }

  if(isDefined(self.overrideplayerdamage))
    idamage = self[[self.overrideplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime);
  else if(isDefined(level.overrideplayerdamage))
    idamage = self[[level.overrideplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime);

  assert(isDefined(idamage), "You must return a value from a damage override function.");
  self callback("on_player_damage");

  if(sweapon == "emp_grenade_sp")
    self notify("emp_grenaded", eattacker);

  switch (sweapon) {
    case "concussion_grenade_80s_sp":
    case "concussion_grenade_sp":
      dist = distance(self.origin, einflictor.origin);
      scale = 1 - dist / 512;
      time = 1 + 4 * scale;
      self shellshock("concussion_grenade_mp", time);
      break;
  }

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    maxhealth = self.maxhealth;
    self.health = self.health + idamage;
    self.maxhealth = maxhealth;
  }

  if(shitloc == "riotshield") {
    return;
  }
  if(isDefined(self.divetoprone) && self.divetoprone == 1) {
    if(smeansofdeath == "MOD_GRENADE_SPLASH") {
      dist = distance2d(vpoint, self.origin);

      if(dist > 32) {
        dot_product = vectordot(anglestoforward(self.angles), vdir);

        if(dot_product > 0)
          idamage = int(idamage * 0.5);
      }
    }
  }

  if(isDefined(eattacker) && (isplayer(eattacker) && eattacker.team == self.team) && (!isDefined(level.friendlyexplosivedamage) || !level.friendlyexplosivedamage)) {
    if(!isDefined(level.is_friendly_fire_on) || ![
        [level.is_friendly_fire_on]
      ]()) {
      if(self != eattacker) {
        println("Exiting - players can't hut each other.");

        return;
      } else if(smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_PROJECTILE" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_BURNED" && smeansofdeath != "MOD_SUICIDE") {
        println("Exiting - damage type verbotten.");

        return;
      }
    }
  }

  if(isDefined(eattacker) && eattacker isvehicle() && issentient(eattacker) && self.team == eattacker.team) {
    return;
  }
  if(isDefined(level.prevent_player_damage)) {
    if(self[[level.prevent_player_damage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime))
      return;
  }

  if(isDefined(eattacker) && eattacker != self) {
    if(idamage > 0 && self.health > 0)
      eattacker thread maps\_damagefeedback::updatedamagefeedback();
  }

  self maps\_dds::update_player_damage(eattacker);

  if(idamage >= self.health) {
    if(smeansofdeath == "MOD_CRUSH" && isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "script_vehicle")
      setdvar("ui_deadquote", "@SCRIPT_MOVING_VEHICLE_DEATH");
  }

  if(isDefined(level.disable_player_damage_knockback) && level.disable_player_damage_knockback)
    idflags = idflags | level.idflags_no_knockback;

  self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime);
}

finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
  self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime);
}

incrgrenadekillcount() {
  if(!isplayer(self)) {
    return;
  }
  if(!isDefined(self.grenadekillcounter))
    self.grenadekillcounter = 0;

  self.grenadekillcounter++;

  if(self.grenadekillcounter >= 5)
    self giveachievement_wrapper("SP_GEN_FRAGMASTER");

  wait 0.25;
  self.grenadekillcounter--;
}

callback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  self endon("death");

  if(isDefined(eattacker)) {
    if(isplayer(eattacker) && eattacker hasperk("specialty_bulletdamage") && maps\_utility_code::isprimarydamage(smeansofdeath)) {
      assert(isDefined(level.cac_bulletdamage_data), "this var must have value");
      idamage = int(idamage * (100 + level.cac_bulletdamage_data) / 100);

      if(getdvarint(#"_id_5ABA6445"))
        println("Perk--> Player bullet did extra damage");

    }
  }

  if(isDefined(self.overrideactordamage))
    idamage = self[[self.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename);
  else if(isDefined(level.overrideactordamage))
    idamage = self[[level.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename);

  if(isDefined(eattacker) && isplayer(eattacker)) {
    level thread maps\_friendlyfire::friendly_fire_callback(self, idamage, eattacker, smeansofdeath);

    if(isDefined(self.playercausedactordamage))
      self thread[[self.playercausedactordamage]]();
  }

  assert(isDefined(idamage), "You must return a value from a damage override function.");
  self callback("on_actor_damage");

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield && !(isDefined(self.bulletcam_death) && self.bulletcam_death)) {
    t = gettime();

    if(t - self._mbs.last_pain_time > 500 || smeansofdeath == "MOD_EXPLOSIVE") {
      if(self.allowpain || isDefined(self._mbs.allow_pain_old) && self._mbs.allow_pain_old)
        enable_pain();

      self._mbs.last_pain_time = t;
      self thread turret_ignore_me_timer(self._mbs.turret_ignore_time);
    } else {
      self._mbs.allow_pain_old = self.allowpain;
      disable_pain();
    }

    self.delayeddeath = 0;
    maxhealth = self.maxhealth;
    self.health = self.health + idamage;
    self.maxhealth = maxhealth;
  } else if(!(isDefined(self.a.doingragdolldeath) && self.a.doingragdolldeath))
    self animscripts\balcony::balconydamage(idamage, smeansofdeath);

  if(isDefined(eattacker) && eattacker != self) {
    if(idamage > 0 && self.health > 0)
      eattacker thread maps\_damagefeedback::updatedamagefeedback();
  }

  self maps\_dds::update_actor_damage(eattacker, smeansofdeath);

  if(self.health - idamage <= 0 && (sweapon == "crossbow_sp" || sweapon == "crossbow_80s_sp"))
    self.dofiringdeath = 0;

  if(self.health > 0 && self.health - idamage <= 0) {
    println("LDS: Dropped scavenger item for entity " + self getentitynumber());

    if(isDefined(eattacker) && isplayer(eattacker.driver))
      eattacker = eattacker.driver;

    if(isplayer(eattacker)) {
      level thread maps\_friendlyfire::friendly_fire_callback(self, -1, eattacker, smeansofdeath);

      println("player killed enemy with " + sweapon + " via " + smeansofdeath);

      if(level.script == "yemen" || self.team == "axis") {
        item = self dropscavengeritem("scavenger_item_sp");
        item thread maps\_weapons::scavenger_think();

        if(sweapon == "explosive_bolt_sp" || sweapon == "crossbow_explosive_alt_sp") {
          killedsofar = 1 + getpersistentprofilevar(0, 0);

          if(killedsofar >= 30)
            eattacker giveachievement_wrapper("SP_GEN_CROSSBOW");

          setpersistentprofilevar(0, killedsofar);
        }

        if(self.isbigdog)
          eattacker inc_general_stat("mechanicalkills");
        else
          eattacker inc_general_stat("kills");

        if((smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH") && (sweapon == "frag_grenade_sp" || sweapon == "frag_grenade_80s_sp"))
          eattacker thread incrgrenadekillcount();

        if(smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_PROJECTILE")
          eattacker inc_general_stat("explosivekills");

        if(smeansofdeath == "MOD_MELEE") {
          eattacker inc_general_stat("meleekills");
          eattacker notify("melee_kill");

          if(sweapon == "pulwar_sword_sp")
            eattacker notify("sword_kill");
          else if(sweapon == "tazer_knuckles_sp")
            eattacker notify("tazer_kill");
        }

        if(shitloc == "head" || shitloc == "helmet")
          eattacker inc_general_stat("headshots");

        if(self isflashed() || self isstunned())
          eattacker inc_general_stat("stunkills");
      }
    }
  }

  self finishactordamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime);
}

finishactordamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
  self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime);
}

callback_reviveplayer() {
  self endon("disconnect");
  self reviveplayer();
}

callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  self endon("disconnect");
  self callback("on_player_last_stand");
  [[maps\_laststand::playerlaststand]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration);
}

callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  self thread[[level.onplayerkilled]](einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration);

  debug_player_death(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration);

  self.downs++;
  dvarname = "player" + self getentitynumber() + "downs";
  setdvar(dvarname, self.downs);

  if(isDefined(level.player_killed_shellshock))
    self shellshock(level.player_killed_shellshock, 3);
  else
    self shellshock("death", 3);

  self playlocalsound("evt_player_death");
  self setmovespeedscale(1.0);
  self.ignoreme = 0;
  self notify("killed_player");
  self callback("on_player_killed");
  wait 1;

  if(isDefined(level.overrideplayerkilled))
    self[[level.overrideplayerkilled]]();

  if(get_players().size > 1) {
    players = get_players();

    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i])) {
        if(!isalive(players[i])) {
          println("Player #" + i + " is dead");

          continue;
        }

        println("Player #" + i + " is alive");

      }
    }

    missionfailed();
    return;
  }

  if(!isDefined(level.spawnclient)) {
    waittillframeend;
    self spawn(self.origin, self.angles);
    return;
  }

}

debug_player_death(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  println("^6[[ Player Killed ]]\\n");

  if(isDefined(einflictor)) {
    println("--eInflictor--");

    if(isDefined(einflictor.classname))
      println("^6classname: " + einflictor.classname);

    if(isDefined(einflictor.targetname))
      println("^6targetname: " + einflictor.targetname);
  }

  if(isDefined(attacker)) {
    println("--attacker--");

    if(isDefined(attacker.classname))
      println("^6classname: " + attacker.classname);

    if(isDefined(attacker.targetname))
      println("^6targetname: " + attacker.targetname);
  }

  if(isDefined(idamage)) {
    println("--iDamage--");
    println("^6" + idamage);
  }

  if(isDefined(smeansofdeath)) {
    println("--sMeansOfDeath--");
    println("^6" + smeansofdeath);
  }

  if(isDefined(sweapon)) {
    println("--sWeapon--");
    println("^6" + sweapon);
  }

  println("\\n^6[[ /Player Killed ]]");
}

callback_actorkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime) {
  if(isDefined(self.overrideactorkilled))
    self[[self.overrideactorkilled]](einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime);
  else if(isDefined(level.overrideactorkilled))
    self[[level.overrideactorkilled]](einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime);

  self callback("on_actor_killed");
}

should_take_hatchet_damage() {
  if(issentient(self))
    return true;
  else if(isDefined(self.is_horse))
    return true;
  else
    return false;
}

callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  self endon("death");

  if(isDefined(self.overridevehicledamage))
    idamage = self[[self.overridevehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname);
  else if(isDefined(level.overridevehicledamage))
    idamage = self[[level.overridevehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname);

  assert(isDefined(idamage), "You must return a value from a damage override function.");
  self callback("on_vehicle_damage");

  if(self isvehicleimmunetodamage(idflags, smeansofdeath, sweapon)) {
    if(isplayer(eattacker) && isDefined(level.vehicle_immune_notify_func))
      self thread[[level.vehicle_immune_notify_func]](smeansofdeath, sweapon);

    return;
  }

  if(self maps\_vehicle::friendlyfire_shield_callback(eattacker, idamage, smeansofdeath)) {
    return;
  }
  if(sweapon == "hatchet_sp" || sweapon == "hatchet_80s_sp") {
    if(!self should_take_hatchet_damage())
      return;
  }

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    self.health = self.health + idamage;

  if(isDefined(eattacker) && isplayer(eattacker)) {
    if(idamage > 0 && self.health > 0)
      eattacker thread maps\_damagefeedback::updatevechicledamagefeedback(sweapon);

    if(self.health > 0 && self.health - idamage <= 0)
      eattacker inc_general_stat("mechanicalkills");
  }

  if(idamage >= self.health) {
    if(isDefined(self.callbackvehiclekilled))
      self[[self.callbackvehiclekilled]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime);
    else if(isDefined(level.callbackvehiclekilled))
      self[[level.callbackvehiclekilled]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime);
  }

  self.last_damage_mod = smeansofdeath;
  self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
}

spawnclient() {
  self endon("disconnect");
  self endon("end_respawn");

  println("*************************spawnClient****");

  self unlink();

  if(isDefined(self.spectate_cam))
    self.spectate_cam delete();

  if(level.otherplayersspectate)
    self thread[[level.spawnspectator]]();
  else
    self thread[[level.spawnplayer]]();
}

spawnplayer(spawnonhost) {
  self endon("disconnect");
  self endon("spawned_spectator");
  self notify("spawned");
  self notify("end_respawn");
  synchronize_players();
  setspawnvariables();
  self.sessionstate = "playing";
  self.spectatorclient = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.statusicon = "";
  self.maxhealth = self.health;
  self.shellshocked = 0;
  self.inwater = 0;
  self.friendlydamage = undefined;
  self.hasspawned = 1;
  self.spawntime = gettime();
  self.afk = 0;

  println("*************************spawnPlayer****");

  self detachall();

  if(isDefined(level.custom_spawnplayer)) {
    self[[level.custom_spawnplayer]]();
    return;
  }

  if(isDefined(level.onspawnplayer))
    self[[level.onspawnplayer]]();

  wait_for_first_player();

  if(isDefined(spawnonhost)) {
    self spawn(get_players()[0].origin, get_players()[0].angles);
    self setplayerspawnpos();
  } else
    self spawn(self.origin, self.angles);

  if(isDefined(level.onpostspawnplayer))
    self[[level.onpostspawnplayer]]();

  if(isDefined(level.onplayerweaponswap))
    self thread[[level.onplayerweaponswap]]();

  self maps\_introscreen::introscreen_player_connect();
  waittillframeend;

  if(self != get_players("all")[0])
    wait 0.5;

  self notify("spawned_player");
}

synchronize_players() {
  if(!isDefined(level.flag) || !isDefined(level.flag["all_players_connected"])) {
    println("^1****ERROR: You must call _load::main() if you don't want bad coop things to happen!****");
    println("^1****ERROR: You must call _load::main() if you don't want bad coop things to happen!****");
    println("^1****ERROR: You must call _load::main() if you don't want bad coop things to happen!****");

    return;
  }

  if(getnumconnectedplayers() == getnumexpectedplayers()) {
    return;
  }
  if(flag("all_players_connected")) {
    return;
  }
  background = undefined;

  if(level.onlinegame || level.systemlink)
    self openmenu("briefing");
  else {
    background = newhudelem();
    background.x = 0;
    background.y = 0;
    background.horzalign = "fullscreen";
    background.vertalign = "fullscreen";
    background.foreground = 1;
    background setshader("black", 640, 480);
  }

  flag_wait("all_players_connected");

  if(level.onlinegame || level.systemlink) {
    players = get_players("all");

    for(i = 0; i < players.size; i++)
      players[i] closemenu();
  } else {
    assert(isDefined(background));
    background destroy();
  }
}

spawnspectator() {
  self endon("disconnect");
  self endon("spawned_spectator");
  self notify("spawned");
  self notify("end_respawn");
  setspawnvariables();
  self.sessionstate = "spectator";
  self.spectatorclient = -1;

  if(isDefined(level.otherplayersspectateclient))
    self.spectatorclient = level.otherplayersspectateclient getentitynumber();

  self setclientdvars("cg_thirdPerson", 0);
  self setspectatepermissions();
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.statusicon = "";
  self.maxhealth = self.health;
  self.shellshocked = 0;
  self.inwater = 0;
  self.friendlydamage = undefined;
  self.hasspawned = 1;
  self.spawntime = gettime();
  self.afk = 0;

  println("*************************spawnSpectator***");

  self detachall();

  if(isDefined(level.onspawnspectator))
    self[[level.onspawnspectator]]();

  self spawn(self.origin, self.angles);
  waittillframeend;
  flag_wait("all_players_connected");
  self notify("spawned_spectator");
}

setspectatepermissions() {
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 0);
  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);
}

spawnintermission() {
  self notify("spawned");
  self notify("end_respawn");
  self setspawnvariables();
  self freezecontrols(0);
  self setclientdvar("cg_everyoneHearsEveryone", "1");
  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  [[level.onspawnintermission]]();
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

default_onspawnplayer() {
}

default_onpostspawnplayer() {
}

default_onspawnspectator() {
}

default_onspawnintermission() {
  spawnpointname = "info_intermission";
  spawnpoints = getentarray(spawnpointname, "classname");

  if(spawnpoints.size < 1) {
    println("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

    return;
  }

  spawnpoint = spawnpoints[randomint(spawnpoints.size)];

  if(isDefined(spawnpoint))
    self spawn(spawnpoint.origin, spawnpoint.angles);
}

player_connect() {
  waittillframeend;

  if(isDefined(self)) {
    level notify("connecting", self);
    b_first_player = is_first_player();

    if(b_first_player)
      level notify("connecting_first_player", self);

    self waittill("spawned_player");
    waittillframeend;

    if(b_first_player) {
      level.player = self;
      flag_set("level.player");
      level notify("first_player_ready", self);
      self callback("on_first_player_connect");
    }

    self callback("on_player_connect");
  }
}

is_first_player() {
  players = get_players();

  if(isDefined(players) && (players.size == 0 || players[0] == self))
    return true;

  return false;
}

setspawnvariables() {
  resettimeout();
  self stopshellshock();
  self stoprumble("damage_heavy");
}