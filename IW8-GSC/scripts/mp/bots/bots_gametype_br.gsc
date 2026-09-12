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
  var_0 = randomfloat(1) < getdvarfloat("br_infil_bot_solojump_chance", 0);
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

      if((scripts\mp\gametypes\br_public::updatedragonsbreath() || var_0) && istrue(level.c130inbounds)) {
        var_1 = level.br_ac130.origin;
        var_2 = vectorNormalize(level.infilstruct.c130pathstruct.endpt - var_1);
        var_3 = (level.br_level.br_mapbounds[0][0] - var_1[0]) / var_2[0];
        var_4 = (level.br_level.br_mapbounds[0][1] - var_1[0]) / var_2[0];
        var_5 = (level.br_level.br_mapbounds[0][1] - var_1[1]) / var_2[1];
        var_6 = (level.br_level.br_mapbounds[1][1] - var_1[1]) / var_2[1];
        var_7 = [var_3, var_4, var_5, var_6];
        var_8 = -1;

        foreach(var_10 in var_7) {
          if(var_10 > 0) {
            if(var_8 < 0 || var_10 < var_8) {
              var_8 = var_10;
            }
          }
        }

        var_12 = var_1 + var_2 * var_8;
        var_13 = scripts\mp\gametypes\br_c130::getc130speed();
        var_14 = var_8 / var_13;

        if(istrue(level.debug_interaction_status) && isDefined(level.infilstruct) && isDefined(level.infilstruct.c130pathstruct) && isDefined(level.infilstruct.c130pathstruct.neurotoxin_damage_monitor)) {
          var_15 = distance(level.infilstruct.c130pathstruct.ref_1386E, level.infilstruct.c130pathstruct.neurotoxin_damage_monitor);
          var_14 = var_15 / var_13;
          var_16 = randomfloatrange(0.3, 0.6) * var_14;
        } else {
          var_16 = randomfloatrange(0.1, 0.9) * var_16;
        }

        wait var_16;

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
      scripts\engine\utility::ref_143A5("death_or_disconnect", "gulag_end");
      wait 3;
    } else {
      self botclearscriptenemy();
    }

    if(isDefined(level.br_circle) && isscriptabledefined()) {
      var_18 = undefined;
      var_19 = self bothasscriptgoal();

      if(var_19) {
        var_18 = self botgetscriptgoal();
      }

      if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        if((istrue(self isskydiving()) || istrue(self isparachuting())) && istrue(self.vehicle_occupancy_monitorgameended) && istrue(scripts\mp\gametypes\br_public::tutorial_playSound())) {
          self botsetflag("disable_all_ai", 0);
          self botclearscriptgoal();
          deadpair();
        } else if(istrue(level.debug_interaction_status) && (istrue(self isskydiving()) || istrue(self isparachuting()))) {
          var_20 = getclosestpointonnavmesh(self.origin, self);
          var_21 = distance2dsquared(self.origin, var_20);
          var_22 = self botgetscriptgoalRadius();

          if(var_21 > var_22 * var_22) {
            self botsetflag("disable_all_ai", 0);
            var_1 = damageshield_time(self, var_20);
            self botlookatpoint(var_20, 0.05, "script_forced");
            self botsetscriptmove(var_1[1], 0.05, 1);
            wait 0.05;
            continue;
          }
        }

        if(scripts\mp\gametypes\br_public::tutorial_playSound() && !isDefined(self.steam_valve_think)) {
          self.ignoreall = 1;
          wait 1;
          continue;
        }

        var_23 = self botpathexists();
        var_24 = !var_19 || !var_23 || !scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_18);

        if(var_19) {
          var_21 = distancesquared(self.origin, var_18);
          var_22 = self botgetscriptgoalRadius();
          var_25 = var_21 < var_22 * var_22;

          if(!var_25) {
            self.lasttimereachedscriptgoal = undefined;
          } else if(!isDefined(self.lasttimereachedscriptgoal)) {
            self.lasttimereachedscriptgoal = gettime();
          }
        }

        var_26 = level.bot_personality_type[self.personality] == "stationary";

        if(isDefined(self.lasttimereachedscriptgoal)) {
          var_27 = 0;

          if(var_26) {
            var_27 = 20000;
          }

          var_24 = var_24 || gettime() - self.lasttimereachedscriptgoal >= var_27;
        }

        if(var_24) {
          var_28 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();
          var_29 = self getclosestreachablepointonnavmesh(var_28);

          if(isDefined(var_29)) {
            self botsetscriptgoal(var_29, 1024, "hunt", undefined, undefined, !var_26);
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
  var_0 = gettime() + randomfloatrange(5, 10) * 1000;
  var_1 = 0;

  while(istrue(self isskydiving()) || istrue(self isparachuting())) {
    if(level.br_circle.circleindex > 0 && istrue(level.group_unset_jugg_standstill) && !scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(self.lategame_buytimer_set)) {
      self.lategame_buytimer_set = damagestate();
    }

    var_2 = damageshield_time(self, self.lategame_buytimer_set);
    var_3 = 1;
    self botlookatpoint(self.lategame_buytimer_set, 0.05, "script_forced");
    self botsetscriptmove(var_2[1], 0.05, var_3);

    if(gettime() > var_0 && !var_1) {
      self botpressbutton("jump", 1);
      var_1 = 1;
    }

    wait 0.05;
  }

  self.steam_valve_think = 1;
  self botlookatpoint(undefined);
  self.ignoreall = 0;
  dangerzoneids();
}

function damagestate(var_0) {
  if(!isDefined(level.playerplunderpickupcallback) || level.playerplunderpickupcallback.size < 1) {
    level.playerplunderpickupcallback = puhostagerestoreweapon();
    level.playerplunderpickupcallback = scripts\engine\utility::array_randomize(level.playerplunderpickupcallback);
  }

  if(isDefined(level.br_circle) && isscriptabledefined()) {
    var_1 = scripts\engine\utility::random(level.playerplunderpickupcallback);

    if(isDefined(var_1)) {
      var_2 = var_1.origin;
      level.playerplunderpickupcallback = scripts\engine\utility::array_remove(level.playerplunderpickupcallback, var_1);
    } else {
      var_2 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();
    }

    return getclosestpointonnavmesh(var_2, self);
  }

  return undefined;
}

function puhostagerestoreweapon() {
  var_0 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  return scripts\engine\utility::get_array_of_closest(var_1, level.deactivate_station, undefined, undefined, var_0);
}

function damageshield_time(var_0, var_1) {
  var_2 = vectorNormalize(var_1 - var_0.origin);
  return vectortoangles(var_2);
}

function damageskipburndown(var_0, var_1) {
  return distance(var_0.origin, var_1);
}

function dangernotifyresetforplayer() {
  if(!isDefined(level.currentsol)) {
    level.currentsol = ["iw8_sm_papa90_mp", "iw8_sh_charlie725_mp", "iw8_ar_akilo47_mp+acog", "iw8_lm_mgolf34_mp", "iw8_sn_kilo98_mp+scope", "iw8_sm_beta_mp+reflexmini2", "iw8_sm_augolf_mp+acog", "iw8_sm_mpapa7_mp+acog", "iw8_ar_falima_mp+reflexmini", "iw8_ar_kilo433_mp+acog", "iw8_ar_scharlie_mp+reflexmini2", "iw8_lm_lima86_mp+acog"];
  }

  var_0 = scripts\engine\utility::random(level.currentsol);

  switch (var_0) {
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

  var_1 = [[level.fnbuildweapon]]([[level.fngetweaponrootname]](var_0), [], "none", "none", -1);
  self giveweapon(var_1);
  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponclipsize(var_1));
  self switchtoweapon("none");
}

function dangerzoneids() {
  self switchtoweapon("none");
  var_0 = propdeductchange();

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = riskspawn_getspawnlocations();
  }

  var_0.claimed = 1;
  var_1 = level.bot_personality_type[self.personality] == "stationary";
  self botsetscriptgoal(self getclosestreachablepointonnavmesh(var_0.origin), 256, "guard", undefined, undefined, !var_1);
  scripts\engine\utility::ref_143A5("goal", "last_stand_start");
  var_0.claimed = undefined;

  if(!istrue(self.inlaststand)) {
    dangernotifyresetforplayer();
  }

  currenttime();
}

function propdeductchange() {
  var_0 = propdeductclonechange();
  var_0 = sortbydistance(var_0, self.origin);
  var_1 = project_to_line_seg(var_0);

  if(!isDefined(var_1)) {
    var_1 = progression_speed(var_0);
  }

  return var_1;
}

function propdeductclonechange() {
  var_0 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_2 = scripts\engine\utility::get_array_of_closest(var_1, level.damage_feedback_watch, undefined, undefined, var_0);
  return var_2;
}

function project_to_line_seg(var_0) {
  foreach(var_2 in var_0) {
    if(!istrue(var_2.claimed)) {
      return var_2;
    }
  }

  return undefined;
}

function progression_speed(var_0) {
  return scripts\engine\utility::getclosest(self.origin, var_0);
}

function mine_caves_breakable_gate_individual() {
  self endon("death_or_disconnect");

  for(;;) {
    wait 0.05;
  }
}

function currenttime() {
  var_0 = level.bot_personality_type[self.personality] == "stationary";
  var_1 = 0;

  for(;;) {
    var_2 = riskspawn_debugdvar();
    var_1 = deactivate_gas_trap_trigger() || istrue(level.group_unset_jugg_standstill);

    if(var_1) {
      var_2 = riskspawn_getspawnlocations();
    }

    if(isDefined(var_2)) {
      var_3 = damagethisround();

      if(istrue(level.debug_jugg_health) && isDefined(var_3) && !var_1) {
        thread ref_13FA7();
        self getenemyinfo(var_3);

        if(self botgetpersonality() != "run_and_gun") {
          scripts\mp\bots\bots_util::bot_set_personality("run_and_gun");
        }

        if(self bothasscriptgoal()) {
          self botclearscriptgoal();
        }

        if(!isDefined(self.ref_12487)) {
          self botsetscriptenemy(var_3);
          self.ref_12487 = var_3;
        }
      } else {
        self.ref_12487 = undefined;
        self notify("update_on_death");

        if(self bothasscriptgoal()) {
          self botclearscriptgoal();
        }

        self botclearscriptenemy();

        if(var_1) {
          self botsetscriptgoal(var_2, 128, "critical", undefined, undefined, 0);
        } else {
          self botsetscriptgoal(var_2, 400, "guard", undefined, undefined, 0);
        }

        if(istrue(var_1)) {
          var_1 = 0;
        }

        thread ref_121FA();
        var_4 = scripts\engine\utility::waittill_any_ents_return(self, "goal", self, "bad path", level, "br_circle_started", self, "last_stand_start", self, "path_timeout");

        if(isDefined(var_4) && var_4 != "bad path" && var_4 != "br_circle_started" && var_4 != "path_timeout" && var_4 != "last_stand_start") {
          var_5 = gettime() + randomintrange(3, 8) * 1000;

          while(gettime() < var_5) {
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

function ref_121FA() {
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
  var_0 = level.bot_personality_type[self.personality] == "stationary";
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
    var_1 = self.arena;

    foreach(var_3 in var_1.arenaplayers) {
      if(var_3 == self) {
        continue;
      }

      if(istrue(var_1.overtime) && isDefined(var_1.managevehiclehealthui) && isDefined(var_1.managevehiclehealthui.arenaflag) && isDefined(var_1.managevehiclehealthui.arenaflag.flagmodel)) {
        self botsetscriptgoal(var_1.managevehiclehealthui.arenaflag.flagmodel.origin, 64, "objective");
        self botclearscriptenemy();
        continue;
      }

      self getenemyinfo(var_3);
      self botsetscriptgoal(self getclosestreachablepointonnavmesh(var_3.origin), 256, "guard");
      self botsetscriptenemy(var_3);
    }

    wait 3;
  }
}

function brprewaitandspawnclientcleanup() {
  self endon("death_or_disconnect");

  for(;;) {
    var_0 = self getweaponslistprimaries();

    if(var_0.size == 1 && var_0[0].basename == "iw8_fists_mp") {
      wait 1;
      continue;
    }

    foreach(var_2 in var_0) {
      if(self getweaponammostock(var_2) < weaponclipsize(var_2)) {
        self setweaponammostock(var_2, weaponclipsize(var_2));
      }
    }

    wait 0.1;
  }
}

function damagethisround() {
  if(isDefined(level.ref_12488) && gettime() <= level.ref_12488) {
    return undefined;
  }

  var_0 = quickdropplaySound();

  if(!isDefined(var_0)) {
    return undefined;
  }

  return var_0;
}

function debug_jugg_maze() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2)) {
      continue;
    }

    if(data_pickup_logic_new(var_2)) {
      var_0++;
    }
  }

  return var_0;
}

function data_pickup_logic_new() {
  return isDefined(self.ref_12487);
}

function quickdropplaySound() {
  var_0 = get_player();
  var_1 = squared(3000);

  if(istrue(self.inlaststand) || scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    return undefined;
  }

  if(!isDefined(var_0) || istrue(var_0.inlaststand) || !isalive(var_0) || var_0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    return undefined;
  }

  if(deactivate_gas_trap_trigger()) {
    return undefined;
  }

  var_2 = prematchrandomloadout();

  if(var_2 >= 3) {
    if(distancesquared(var_0.origin, self.origin) > var_1) {
      return undefined;
    }

    var_3 = debug_jugg_maze();

    if(data_pickup_logic_new()) {
      return var_0;
    }

    if(var_3 >= 1) {
      return undefined;
    }

    return var_0;
  }

  return var_1;
}

function get_player() {
  foreach(var_1 in level.players) {
    if(!isbot(var_1)) {
      return var_1;
    }
  }
}

function ref_13FA7() {
  self notify("update_on_death");
  self endon("update_on_death");
  scripts\engine\utility::ref_143A6("death", "death_or_disconnect", "last_stand_start");
  self.ref_12487 = undefined;
  level.ref_12488 = gettime() + 7;
}

function deactivate_gas_trap_trigger() {
  var_0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_1 = scripts\mp\gametypes\br_circle::getdangercircleradius();

  if(istrue(level.group_unset_jugg_standstill)) {
    var_0 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var_1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  }

  if(scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    return false;
  }

  if(!isalive(self) || self.sessionstate != "playing") {
    return false;
  }

  return !scripts\engine\utility::updatescrapassistdata(self.origin, var_0, var_1);
}

function riskspawn_debugobjective(var_0) {
  var_1 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();

  if(!isDefined(var_0)) {
    var_0 = 1000;
  }

  if(distance2d(self.origin, var_1) > var_0) {
    var_2 = vectortoangles(var_1 - self.origin);
    var_3 = anglesToForward(var_2);
    var_1 = self.origin + var_3 * var_0;
  }

  return self getclosestreachablepointonnavmesh(var_1);
}

function riskspawn_getspawnlocations() {
  var_0 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_2 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_0, var_1, 0.75, 0.9, 1, 1);
  return self getclosestreachablepointonnavmesh(var_2);
}

function riskspawn_debugdvar() {
  var_0 = gettime() + 5000;

  while(gettime() < var_0) {
    var_1 = scripts\mp\gametypes\br_circle::getrandompointincircle(self.origin, 750, 0.6, 1, 1, 1);
    var_2 = self getclosestreachablepointonnavmesh(var_1);

    if(updateprematchloadoutarray(var_2)) {
      return var_2;
    }

    wait 0.05;
  }

  var_3 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();
  return self getclosestreachablepointonnavmesh(var_3);
}

function updateprematchloadoutarray(var_0) {
  var_1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_2 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  return scripts\engine\utility::updatescrapassistdata(var_0, var_1, var_2);
}

function prematchrandomloadout() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2) || !isalive(var_2) || var_2.sessionstate != "playing") {
      continue;
    }

    var_0++;
  }

  return var_0;
}

function debug_freight_lift(var_0) {
  var_1 = level.teamdata[var_0.team]["alivePlayers"];

  if(scripts\engine\utility::array_contains(var_1, self)) {
    return true;
  }

  return false;
}