/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_br.gsc
************************************************/

function main() {
  if(scripts\mp\utility\game::round_vehicle_logic() == "dmz" && scripts\mp\gametypes\br_public::uniquelootcallbacks()) {
    [[level.lootchopper_initcircleinfo]]();
    return;
  }

  setup_callbacks();
  setup_bot_br();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_br_think;
}

function setup_bot_br() {
  setdvarifuninitialized("br_infil_bot_solojump_chance", 0.25);
}

function bot_br_think() {
  self notify("bot_br_think");
  self endon("bot_br_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var0 = randomfloat(1) < getdvarfloat("br_infil_bot_solojump_chance", 0);
  thread brprewaitandspawnclientcleanup();
  self botsetflag("ignore_nodes", 1);

  for(;;) {
    if(scripts\mp\gametypes\br_public::tutorial_playSound() && !scripts\mp\flags::gameflag("graceperiod_done")) {
      self.ignoreall = 0;
      wait 0.05;
      continue;
    }

    if(isDefined(self.br_infil_type)) {
      if(scripts\mp\gametypes\br_public::tutorial_playSound() && !isDefined(self.steam_valve_think)) {
        self.ignoreall = 1;
        self botclearscriptgoal();
      }

      self botsetflag("disable_all_ai", 1);

      if((scripts\mp\gametypes\br_public::updatedragonsbreath() || var0) && istrue(level.c130inbounds)) {
        var1 = level.br_ac130.origin;
        var2 = vectorNormalize(level.infilstruct.c130pathstruct.endpt - var1);
        var3 = (level.br_level.br_mapbounds[0][0] - var1[0]) / var2[0];
        var4 = (level.br_level.br_mapbounds[0][1] - var1[0]) / var2[0];
        var5 = (level.br_level.br_mapbounds[0][1] - var1[1]) / var2[1];
        var6 = (level.br_level.br_mapbounds[1][1] - var1[1]) / var2[1];
        var7 = [var3, var4, var5, var6];
        var8 = -1;

        foreach(var10 in var7) {
          if(var10 > 0) {
            if(var8 < 0 || var10 < var8) {
              var8 = var10;
            }
          }
        }

        var12 = var1 + var2 * var8;
        var13 = scripts\mp\gametypes\br_c130::getc130speed();
        var14 = var8 / var13;

        if(istrue(level.debug_interaction_status) && isDefined(level.infilstruct) && isDefined(level.infilstruct.c130pathstruct) && isDefined(level.infilstruct.c130pathstruct.neurotoxin_damage_monitor)) {
          var15 = distance(level.infilstruct.c130pathstruct.ref_1386e, level.infilstruct.c130pathstruct.neurotoxin_damage_monitor);
          var14 = var15 / var13;
          var16 = randomfloatrange(0.3, 0.6) * var14;
        } else {
          var16 = randomfloatrange(0.1, 0.9) * var16;
        }

        wait var16;

        if(scripts\mp\gametypes\br_public::updatedragonsbreath()) {
          self notify("halo_jump_c130");
        } else {
          self notify("halo_jump_solo_c130");
        }

        self.gulaguses = 1;

        if(getdvarint("scr_bot_allow_gulag", 1) > 0) {
          self.gulaguses = 0;
        }

        self.vehicle_occupancy_monitorgameended = 1;

        while(isDefined(self.br_infil_type)) {
          wait 0.05;
        }
      }

      wait 0.05;
      continue;
    }

    if(scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      thread dangerzoneskipequipment();
      scripts\engine\utility::ref_143a5("death_or_disconnect", "gulag_end");
      wait 3;
    } else {
      self botclearscriptenemy();
    }

    if(isDefined(level.br_circle) && isscriptabledefined()) {
      var18 = undefined;
      var19 = self bothasscriptgoal();

      if(var19) {
        var18 = self botgetscriptgoal();
      }

      if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        if((istrue(self isskydiving()) || istrue(self isparachuting())) && istrue(self.vehicle_occupancy_monitorgameended) && istrue(scripts\mp\gametypes\br_public::tutorial_playSound())) {
          self botsetflag("disable_all_ai", 0);
          self botclearscriptgoal();
          deadpair();
        } else if(istrue(level.debug_interaction_status) && (istrue(self isskydiving()) || istrue(self isparachuting()))) {
          var20 = getclosestpointonnavmesh(self.origin, self);
          var21 = distance2dsquared(self.origin, var20);
          var22 = self botgetscriptgoalRadius();

          if(var21 > var22 * var22) {
            self botsetflag("disable_all_ai", 0);
            var1 = damageshield_time(self, var20);
            self botlookatpoint(var20, 0.05, "script_forced");
            self botsetscriptmove(var1[1], 0.05, 1);
            wait 0.05;
            continue;
          }
        }

        if(scripts\mp\gametypes\br_public::tutorial_playSound() && !isDefined(self.steam_valve_think)) {
          self.ignoreall = 1;
          wait 1;
          continue;
        }

        var23 = self botpathexists();
        var24 = !var19 || !var23 || !scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var18);

        if(var19) {
          var21 = distancesquared(self.origin, var18);
          var22 = self botgetscriptgoalRadius();
          var25 = var21 < var22 * var22;

          if(!var25) {
            self.lasttimereachedscriptgoal = undefined;
          } else if(!isDefined(self.lasttimereachedscriptgoal)) {
            self.lasttimereachedscriptgoal = gettime();
          }
        }

        var26 = level.bot_personality_type[self.personality] == "stationary";

        if(isDefined(self.lasttimereachedscriptgoal)) {
          var27 = 0;

          if(var26) {
            var27 = 20000;
          }

          var24 = var24 || gettime() - self.lasttimereachedscriptgoal >= var27;
        }

        if(var24) {
          var28 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();
          var29 = self getclosestreachablepointonnavmesh(var28);

          if(isDefined(var29)) {
            self botsetscriptgoal(var29, 1024, "hunt", undefined, undefined, !var26);
            self.lasttimereachedscriptgoal = gettime();
          }
        }
      }
    } else {
      scripts\mp\bots\bots_personality::update_personality_default();
    }

    wait 0.05;
  }
}

function deadpair() {
  self endon("death_or_disconnect");
  self.ignoreall = 1;
  self.lategame_buytimer_set = damagestate();
  var0 = gettime() + randomfloatrange(5, 10) * 1000;
  var1 = 0;

  while(istrue(self isskydiving()) || istrue(self isparachuting())) {
    if(level.br_circle.circleindex > 0 && istrue(level.group_unset_jugg_standstill) && !scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(self.lategame_buytimer_set)) {
      self.lategame_buytimer_set = damagestate();
    }

    var2 = damageshield_time(self, self.lategame_buytimer_set);
    var3 = 1;
    self botlookatpoint(self.lategame_buytimer_set, 0.05, "script_forced");
    self botsetscriptmove(var2[1], 0.05, var3);

    if(gettime() > var0 && !var1) {
      self botpressbutton("jump", 1);
      var1 = 1;
    }

    wait 0.05;
  }

  self.steam_valve_think = 1;
  self botlookatpoint(undefined);
  self.ignoreall = 0;
  dangerzoneids();
}

function damagestate(var0) {
  if(!isDefined(level.playerplunderpickupcallback) || level.playerplunderpickupcallback.size < 1) {
    level.playerplunderpickupcallback = puhostagerestoreweapon();
    level.playerplunderpickupcallback = scripts\engine\utility::array_randomize(level.playerplunderpickupcallback);
  }

  if(isDefined(level.br_circle) && isscriptabledefined()) {
    var1 = scripts\engine\utility::random(level.playerplunderpickupcallback);

    if(isDefined(var1)) {
      var2 = var1.origin;
      level.playerplunderpickupcallback = scripts\engine\utility::array_remove(level.playerplunderpickupcallback, var1);
    } else {
      var2 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();
    }

    return getclosestpointonnavmesh(var2, self);
  }

  return undefined;
}

function puhostagerestoreweapon() {
  var0 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  return scripts\engine\utility::get_array_of_closest(var1, level.deactivate_station, undefined, undefined, var0);
}

function damageshield_time(var0, var1) {
  var2 = vectorNormalize(var1 - var0.origin);
  return vectortoangles(var2);
}

function damageskipburndown(var0, var1) {
  return distance(var0.origin, var1);
}

function dangernotifyresetforplayer() {
  if(!isDefined(level.currentsol)) {
    level.currentsol = ["iw8_sm_papa90_mp", "iw8_sh_charlie725_mp", "iw8_ar_akilo47_mp+acog", "iw8_lm_mgolf34_mp", "iw8_sn_kilo98_mp+scope", "iw8_sm_beta_mp+reflexmini2", "iw8_sm_augolf_mp+acog", "iw8_sm_mpapa7_mp+acog", "iw8_ar_falima_mp+reflexmini", "iw8_ar_kilo433_mp+acog", "iw8_ar_scharlie_mp+reflexmini2", "iw8_lm_lima86_mp+acog"];
  }

  var0 = scripts\engine\utility::random(level.currentsol);

  switch (var0) {
    case "iw8_sh_charlie725_mp":
      if(!isDefined(level.deathnoise)) {
        level.deathnoise = 0;
      }

      level.deathnoise++;

      if(level.deathnoise >= 1) {
        level.currentsol = scripts\engine\utility::array_remove(level.currentsol, "iw8_sh_charlie725_mp");
      }

      break;
    case "iw8_sn_kilo98_mp+scope":
      if(!isDefined(level.deavtivate_destructible_cinderblock)) {
        level.deavtivate_destructible_cinderblock = 0;
      }

      level.deavtivate_destructible_cinderblock++;

      if(level.deavtivate_destructible_cinderblock >= 1) {
        level.currentsol = scripts\engine\utility::array_remove(level.currentsol, "iw8_sn_kilo98_mp+scope");
      }

      break;
  }

  var1 = [[level.fnbuildweapon]]([[level.fngetweaponrootname]](var0), [], "none", "none", -1);
  self giveweapon(var1);
  self setweaponammoclip(var1, weaponclipsize(var1));
  self setweaponammostock(var1, weaponclipsize(var1));
  self switchtoweapon("none");
}

function dangerzoneids() {
  self switchtoweapon("none");
  var0 = propdeductchange();

  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.origin = riskspawn_getspawnlocations();
  }

  var0.claimed = 1;
  var1 = level.bot_personality_type[self.personality] == "stationary";
  self botsetscriptgoal(self getclosestreachablepointonnavmesh(var0.origin), 256, "guard", undefined, undefined, !var1);
  scripts\engine\utility::ref_143a5("goal", "last_stand_start");
  var0.claimed = undefined;

  if(!istrue(self.inlaststand)) {
    dangernotifyresetforplayer();
  }

  currenttime();
}

function propdeductchange() {
  var0 = propdeductclonechange();
  var0 = sortbydistance(var0, self.origin);
  var1 = project_to_line_seg(var0);

  if(!isDefined(var1)) {
    var1 = progression_speed(var0);
  }

  return var1;
}

function propdeductclonechange() {
  var0 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var2 = scripts\engine\utility::get_array_of_closest(var1, level.damage_feedback_watch, undefined, undefined, var0);
  return var2;
}

function project_to_line_seg(var0) {
  foreach(var2 in var0) {
    if(!istrue(var2.claimed)) {
      return var2;
    }
  }

  return undefined;
}

function progression_speed(var0) {
  return scripts\engine\utility::getclosest(self.origin, var0);
}

function mine_caves_breakable_gate_individual() {
  self endon("death_or_disconnect");

  for(;;) {
    wait 0.05;
  }
}

function currenttime() {
  var0 = level.bot_personality_type[self.personality] == "stationary";
  var1 = 0;

  for(;;) {
    var2 = riskspawn_debugdvar();
    var1 = deactivate_gas_trap_trigger() || istrue(level.group_unset_jugg_standstill);

    if(var1) {
      var2 = riskspawn_getspawnlocations();
    }

    if(isDefined(var2)) {
      var3 = damagethisround();

      if(istrue(level.debug_jugg_health) && isDefined(var3) && !var1) {
        thread ref_13fa7();
        self getenemyinfo(var3);

        if(self botgetpersonality() != "run_and_gun") {
          scripts\mp\bots\bots_util::bot_set_personality("run_and_gun");
        }

        if(self bothasscriptgoal()) {
          self botclearscriptgoal();
        }

        if(!isDefined(self.ref_12487)) {
          self botsetscriptenemy(var3);
          self.ref_12487 = var3;
        }
      } else {
        self.ref_12487 = undefined;
        self notify("update_on_death");

        if(self bothasscriptgoal()) {
          self botclearscriptgoal();
        }

        self botclearscriptenemy();

        if(var1) {
          self botsetscriptgoal(var2, 128, "critical", undefined, undefined, 0);
        } else {
          self botsetscriptgoal(var2, 400, "guard", undefined, undefined, 0);
        }

        if(istrue(var1)) {
          var1 = 0;
        }

        thread ref_121fa();
        var4 = scripts\engine\utility::waittill_any_ents_return(self, "goal", self, "bad path", level, "br_circle_started", self, "last_stand_start", self, "path_timeout");

        if(isDefined(var4) && var4 != "bad path" && var4 != "br_circle_started" && var4 != "path_timeout" && var4 != "last_stand_start") {
          var5 = gettime() + randomintrange(3, 8) * 1000;

          while(gettime() < var5) {
            if(deactivate_gas_trap_trigger()) {
              self.ref_12487 = undefined;
              self notify("update_on_death");
              break;
            }

            wait 0.1;
          }
        }
      }
    }

    wait 1;
  }
}

function ref_121fa() {
  self endon("last_stand_start");
  level endon("game_ended");
  self endon("goal");
  self endon("bad path");
  level endon("br_circle_started");
  wait 15;
  self notify("path_timeout");
}

function dangerzoneskipequipment() {
  self endon("death_or_disconnect");
  self endon("gulag_end");
  level endon("game_ended");
  var0 = level.bot_personality_type[self.personality] == "stationary";
  self.ref_12487 = undefined;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self botclearscriptgoal();

  while(!istrue(self.gulagarena)) {
    wait 1;
  }

  self.ignoreme = 0;
  self.ignoreall = 0;
  scripts\mp\bots\bots_util::bot_set_personality("run_and_gun");

  for(;;) {
    var1 = self.arena;

    foreach(var3 in var1.arenaplayers) {
      if(var3 == self) {
        continue;
      }

      if(istrue(var1.overtime) && isDefined(var1.managevehiclehealthui) && isDefined(var1.managevehiclehealthui.arenaflag) && isDefined(var1.managevehiclehealthui.arenaflag.flagmodel)) {
        self botsetscriptgoal(var1.managevehiclehealthui.arenaflag.flagmodel.origin, 64, "objective");
        self botclearscriptenemy();
        continue;
      }

      self getenemyinfo(var3);
      self botsetscriptgoal(self getclosestreachablepointonnavmesh(var3.origin), 256, "guard");
      self botsetscriptenemy(var3);
    }

    wait 3;
  }
}

function brprewaitandspawnclientcleanup() {
  self endon("death_or_disconnect");

  for(;;) {
    var0 = self getweaponslistprimaries();

    if(var0.size == 1 && var0[0].basename == "iw8_fists_mp") {
      wait 1;
      continue;
    }

    foreach(var2 in var0) {
      if(self getweaponammostock(var2) < weaponclipsize(var2)) {
        self setweaponammostock(var2, weaponclipsize(var2));
      }
    }

    wait 0.1;
  }
}

function damagethisround() {
  if(isDefined(level.ref_12488) && gettime() <= level.ref_12488) {
    return undefined;
  }

  var0 = quickdropplaySound();

  if(!isDefined(var0)) {
    return undefined;
  }

  return var0;
}

function debug_jugg_maze() {
  var0 = 0;

  foreach(var2 in level.players) {
    if(!isbot(var2)) {
      continue;
    }

    if(data_pickup_logic_new(var2)) {
      var0++;
    }
  }

  return var0;
}

function data_pickup_logic_new() {
  return isDefined(self.ref_12487);
}

function quickdropplaySound() {
  var0 = get_player();
  var1 = squared(3000);

  if(istrue(self.inlaststand) || scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    return undefined;
  }

  if(!isDefined(var0) || istrue(var0.inlaststand) || !isalive(var0) || var0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    return undefined;
  }

  if(deactivate_gas_trap_trigger()) {
    return undefined;
  }

  var2 = prematchrandomloadout();

  if(var2 >= 3) {
    if(distancesquared(var0.origin, self.origin) > var1) {
      return undefined;
    }

    var3 = debug_jugg_maze();

    if(data_pickup_logic_new()) {
      return var0;
    }

    if(var3 >= 1) {
      return undefined;
    }

    return var0;
  }

  return var1;
}

function get_player() {
  foreach(var1 in level.players) {
    if(!isbot(var1)) {
      return var1;
    }
  }
}

function ref_13fa7() {
  self notify("update_on_death");
  self endon("update_on_death");
  scripts\engine\utility::ref_143a6("death", "death_or_disconnect", "last_stand_start");
  self.ref_12487 = undefined;
  level.ref_12488 = gettime() + 7;
}

function deactivate_gas_trap_trigger() {
  var0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var1 = scripts\mp\gametypes\br_circle::getdangercircleradius();

  if(istrue(level.group_unset_jugg_standstill)) {
    var0 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  }

  if(scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    return false;
  }

  if(!isalive(self) || self.sessionstate != "playing") {
    return false;
  }

  return !scripts\engine\utility::updatescrapassistdata(self.origin, var0, var1);
}

function riskspawn_debugobjective(var0) {
  var1 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();

  if(!isDefined(var0)) {
    var0 = 1000;
  }

  if(distance2d(self.origin, var1) > var0) {
    var2 = vectortoangles(var1 - self.origin);
    var3 = anglesToForward(var2);
    var1 = self.origin + var3 * var0;
  }

  return self getclosestreachablepointonnavmesh(var1);
}

function riskspawn_getspawnlocations() {
  var0 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var2 = scripts\mp\gametypes\br_circle::getrandompointincircle(var0, var1, 0.75, 0.9, 1, 1);
  return self getclosestreachablepointonnavmesh(var2);
}

function riskspawn_debugdvar() {
  var0 = gettime() + 5000;

  while(gettime() < var0) {
    var1 = scripts\mp\gametypes\br_circle::getrandompointincircle(self.origin, 750, 0.6, 1, 1, 1);
    var2 = self getclosestreachablepointonnavmesh(var1);

    if(updateprematchloadoutarray(var2)) {
      return var2;
    }

    wait 0.05;
  }

  var3 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();
  return self getclosestreachablepointonnavmesh(var3);
}

function updateprematchloadoutarray(var0) {
  var1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var2 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  return scripts\engine\utility::updatescrapassistdata(var0, var1, var2);
}

function prematchrandomloadout() {
  var0 = 0;

  foreach(var2 in level.players) {
    if(!isbot(var2) || !isalive(var2) || var2.sessionstate != "playing") {
      continue;
    }

    var0++;
  }

  return var0;
}

function debug_freight_lift(var0) {
  var1 = level.teamdata[var0.team]["alivePlayers"];

  if(scripts\engine\utility::array_contains(var1, self)) {
    return true;
  }

  return false;
}