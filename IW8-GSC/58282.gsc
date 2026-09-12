/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58282.gsc
***********************************************/

function ref_11ed7() {
  level._effects["vfx_nova_round_scrnfx"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_nova_round_scrnfx");
  level._effect["vfx_chem_round_enemy_death"] = loadfx("vfx/iw8_br/island/weap/_imp/chem_round/vfx_br3_chem_smk_down_enemy");
  level._effect["vfx_br3_canister_exp_large_chem"] = loadfx("vfx/iw8_br/island/weap/_imp/cannister/vfx_br3_canister_exp_large_chem");
  scripts\cp_mp\utility\script_utility::registersharedfunc("nova_rounds", "hitByNovaRounds", &spawn_juggernauts_hangar);
  scripts\mp\utility\sound::besttime("proj_bullet_chem_rounds");
  test_bag_pickup();
  thread ref_11ed8();
}

function test_bag_pickup() {
  if(!isDefined(level.getserverroomspawnpoint)) {
    level.getserverroomspawnpoint = spawnStruct();
    level.getserverroomspawnpoint.plunder_economy_shapshot_loop = [];
  }

  level.getserverroomspawnpoint.ref_127e0 = getdvarfloat("scr_chem_rounds_poisoned_duration", 5);
  level.getserverroomspawnpoint.plunder_awarded_by_missions_total = getdvarfloat("scr_chem_rounds_gas_cloud_lifetime", 10);
  level.getserverroomspawnpoint.plunder_getleveldataforrepository = getdvarfloat("scr_chem_rounds_gas_damage_per_tick", 5);
  level.getserverroomspawnpoint.gas_damage_per_tick_agent_multiplier = getdvarfloat("scr_chem_rounds_gas_damage_per_tick_agent_multiplier", 5);
  level.getserverroomspawnpoint.plunder_clearrepositorywidgetforplayer = getdvarint("scr_chem_rounds_gas_cloud_size", 180);
  level.getserverroomspawnpoint.gas_cloud_height = getdvarint("scr_chem_rounds_gas_cloud_height", 96);
}

function ref_11ed8() {
  waitframe();

  if(getdvarint("scr_city_killer_nova_rounds_chain_cloud", 0) == 1) {
    level.brjugg_watchtimerstart = 1;
  }

  level.ref_12074 = &ref_1447f;
  level.ref_120ad _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty(&gettacroverspawns, level);
  level.ref_120ae _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty(&getteamcarriedplunder, level);
  level.ref_1203f = &spawn_juggernauts_hangar;
}

function spawn_juggernauts_hangar(var_0, var_1, var_2, var_3) {
  if(istrue(var_0.should_take_damage) || istrue(var_0.waittill_trigger_player) || istrue(var_3)) {
    if(isDefined(var_1)) {
      if(isDefined(var_2)) {
        var_4 = easepower("vfx_chem_rounds_enemy_hit", var_1);
        thread ref_12aab(var_4);

        if(!istrue(var_2.updateteamplunderscore)) {
          if(isPlayer(var_2)) {
            stopfxontagforclients(level._effects["vfx_nova_round_scrnfx"], var_2, "j_head", var_2);
            playfxontagforclients(level._effects["vfx_nova_round_scrnfx"], var_2, "j_head", var_2);
          }

          var_2.updateteamplunderscore = 1;

          if(isDefined(self)) {
            self playlocalsound("bullet_chem_round_dmg_plr_trans");
          }
        }

        thread ref_1447f(var_2);
        return;
      }

      return;
    }

    return;
  }
}

function ref_12aab(var_0) {
  level endon("game_ended");
  wait var_0;
  self freescriptable();
}

function ref_1447f(var_0, var_1) {
  if(isPlayer(self) || isbot(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");
  self notify("poisoned_watching_for_death");
  self endon("poisoned_watching_for_death");
  var_2 = level.getserverroomspawnpoint.ref_127e0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  if(var_2 > 0) {
    var_3 = scripts\engine\utility::ref_143b9(level.getserverroomspawnpoint.ref_127e0, "death");

    if(var_3 == "timeout") {
      if(isPlayer(self)) {
        stopfxontagforclients(level._effects["vfx_nova_round_scrnfx"], self, "j_head", self);
        self.updateteamplunderscore = 0;
      }

      return;
    }
  } else {
    self waittill("death");
  }

  if(isPlayer(self)) {
    stopfxontagforclients(level._effects["vfx_nova_round_scrnfx"], self, "j_head", self);
    self.updateteamplunderscore = 0;
  }

  var_4 = self.origin;
  var_5 = easepower("super_nova_rounds_audio", var_4);
  var_6 = spawn("trigger_radius", var_4, 0, level.getserverroomspawnpoint.plunder_clearrepositorywidgetforplayer, level.getserverroomspawnpoint.gas_cloud_height);
  var_6.attacker = var_0;
  waitframe();
  var_7 = easepower("vfx_chem_rounds_enemy_death", var_4);
  var_5 setscriptablepartstate("sfx_gas_npc", "npc_gas_expl");
  scripts\mp\utility\trigger::makeenterexittrigger(var_6, &ref_13dab, &ref_13dac, undefined, undefined, &ref_13da5);
  level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_add(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6);
  wait level.getserverroomspawnpoint.plunder_awarded_by_missions_total;
  level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_remove(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6);

  foreach(var_9 in var_6.triggerenterents) {
    if(getstreamedinplayercount(var_9)) {
      var_9 scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_rounds_gas");
    }
  }

  var_5 freescriptable();
  var_6 notify("gas_cloud_disipate");
  var_7 freescriptable();
  var_6 delete();
}

function playericonfilter(var_0, var_1, var_2, var_3) {
  var_4 = easepower("super_nova_rounds_audio", var_1);
  var_4 setscriptablepartstate("sfx_weapon_chem", "sfx_weapon_chem_sweetner");
  var_5 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level.getserverroomspawnpoint.gas_cloud_height);
  var_6 = spawn("trigger_radius", var_1, 0, var_5, var_5);
  var_6.attacker = var_0;
  scripts\mp\utility\trigger::makeenterexittrigger(var_6, &ref_13dab, &ref_13dac, undefined, undefined, &ref_13da5);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "vfx_chem_rounds_enemy_death");

  if(isDefined(var_2) && var_2 == "nospawn") {
    var_7 = "nospawn";
  }

  if(var_7 != "nospawn") {
    var_8 = easepower(var_7, var_1);
    thread ref_12aab(var_8);
  }

  level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_add(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6);
  wait level.getserverroomspawnpoint.plunder_awarded_by_missions_total;
  level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_remove(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6);

  foreach(var_10 in var_6.triggerenterents) {
    if(getstreamedinplayercount(var_10)) {
      var_10 scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_rounds_gas");
    }
  }

  var_6 notify("gas_cloud_disipate");
  var_6 delete();
  var_4 freescriptable();
}

function ref_13dab(var_0, var_1) {
  thread ref_11c1d(var_0);
}

function ref_13dac(var_0, var_1) {
  var_0.start_coop_escape_safehouse = 0;
  var_0 notify("out_of_poison_cloud");

  if(isPlayer(var_0) && getstreamedinplayercount(var_0)) {
    scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_rounds_gas");
    return;
  }
}

function ref_13da5(var_0, var_1) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(isPlayer(var_0) || isbot(var_0) || isagent(var_0)) {
    return false;
  }

  return true;
}

function getstreamedinplayercount() {
  foreach(var_1 in level.getserverroomspawnpoint.plunder_economy_shapshot_loop) {
    if(scripts\engine\utility::array_contains(var_1.triggerenterents, self)) {
      return false;
    }
  }

  return true;
}

function ref_11c1d(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("gas_damage_watcher_triggered");
  self endon("gas_damage_watcher_triggered");
  var_1 = 0;

  for(;;) {
    wait 0.5;

    if(!isDefined(var_0)) {
      break;
    }

    if(!scripts\engine\utility::array_contains(var_0.triggerenterents, self)) {
      break;
    }

    if(isDefined(var_0.attacker) && isDefined(var_0.attacker.team)) {
      if(self.team == var_0.attacker.team && self != var_0.attacker) {
        break;
      }
    }

    if(isDefined(self.¬»ðÈP·­­² Šø• g) && self.¬»ðÈP·­­² Šø• g) {
      break;
    }

    if(istrue(self.start_death_from_above_sequence)) {
      if(!scripts\mp\gametypes\br_pickups::ks_circlecount(self)) {
        scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_rounds_gas");
      }

      continue;
    }

    if(scripts\cp_mp\gasmask::hasgasmask(self)) {
      if(!scripts\mp\gametypes\br_pickups::ks_circlecount(self)) {
        scripts\mp\gametypes\br_pickups::plunderrepositoryref("chem_rounds_gas");
      }

      scripts\cp_mp\gasmask::processdamage(level.getserverroomspawnpoint.plunder_getleveldataforrepository);
    } else {
      if(!is_player_visible_to_trigger(var_0, self)) {
        continue;
      }

      if(istrue(level.brjugg_watchtimerstart) && self.health - level.getserverroomspawnpoint.plunder_getleveldataforrepository <= 0) {
        self.updateteamplunderscore = 1;
        thread ref_1447f(var_0.attacker);
      }

      var_2 = scripts\engine\utility::ter_op(isagent(self), level.getserverroomspawnpoint.gas_damage_per_tick_agent_multiplier, 1);
      var_3 = level.getserverroomspawnpoint.plunder_getleveldataforrepository * var_2;

      if(scripts\mp\gametypes\br_public::hasarmor()) {
        scripts\mp\gametypes\br_public::damagearmor(var_3);
      } else {
        var_4 = var_0.attacker;

        if(!isDefined(var_0.attacker) || isDefined(var_0.attacker.unittype) && var_0.attacker.unittype == "zombie" && !isalive(var_0.attacker)) {
          var_4 = self;
        }

        self dodamage(var_3, var_0.origin, var_4, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }

      if(isagent(self)) {
        var_5 = easepower("vfx_chem_rounds_enemy_hit", self.origin + (0, 0, 50));
        thread ref_12aab(var_5);
      }

      if(!scripts\mp\gametypes\br_pickups::ks_circlecount(self)) {
        scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_rounds_gas");
      }
    }

    scripts\mp\gametypes\br_circle::ref_13e18();
  }

  scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_rounds_gas");
}

function getsearchparams() {
  self notify("watching_chem_missile");
  self endon("watching_chem_missile");
  self endon("stop_watching_chem_fire");
  level endon("game_ended");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(!istrue(self.ref_11ed4)) {
      return;
    }

    thread getserachparams(var_0);
  }
}

function getscrapassistplayers() {
  self notify("watching_chem_projectile");
  self endon("watching_chem_projectile");
  self endon("stop_watching_chem_fire");
  level endon("game_ended");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = weaponinventorytype(var_1.basename);

    if(var_2 != "primary") {
      continue;
    }

    if(!istrue(self.ref_11ed4)) {
      return;
    }

    thread getserachparams(var_0);
  }
}

function getserachparams(var_0) {
  self waittill("explode", var_1);
  thread playericonfilter(var_0, var_1);
  thread ref_13580(var_0);
}

function ref_12be2() {
  wait 0.1;

  if(isDefined(self)) {
    self.ref_11ed4 = 0;
    self notify("stop_watching_chem_fire");
    return;
  }
}

function ref_13580(var_0) {
  level endon("game_ended");
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin");
  waitframe();
  var_1.ref_14293 = playFXOnTag(scripts\engine\utility::getfx("vfx_br3_canister_exp_large_chem"), var_1, "tag_origin");
  var_2 = 2;
  wait level.getserverroomspawnpoint.plunder_awarded_by_missions_total - var_2;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_br3_canister_exp_large_chem"), var_1, "tag_origin");
  var_1 delete();
}

function ref_11ed6() {
  var_0 = self.lastweaponobj;
  var_1 = isundefinedweapon();

  if(!scripts\mp\weapons::isnormallastweapon(var_0) || scripts\mp\utility\weapon::ismeleeonly(var_0) || scripts\mp\utility\weapon::isgamemodeweapon(var_0) || scripts\mp\utility\weapon::isaxeweapon(var_0) || !getsubgametype(var_0) || getstancetop(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPPORT_BOX_INCOMPAT");
    }

    return false;
  }

  self.should_take_damage = 1;
  self.ref_11ed4 = 1;
  thread getsearchparams();
  thread getscrapassistplayers();
  var_2 = getsixthsensedirection();

  if(!istrue(var_2)) {
    return false;
  }

  if(self isalternatemode(var_0)) {
    var_1 = var_0;
    var_0 = var_0 getnoaltweapon();
  } else {
    var_1 = var_0 getaltweapon();
  }

  var_3 = [];
  var_4 = 0;
  var_5 = 0;

  if(!nullweapon(var_1)) {
    var_3 = var_1;
  }

  var_3 = var_0;

  foreach(var_7 in var_3) {
    var_8 = scripts\mp\utility\weapon::turnexfiltoside(var_7);

    if(isnullweapon(var_7, var_0, 0)) {
      var_9 = scripts\mp\weapons::getammooverride(var_7);
      var_10 = var_9 * 1;

      if(var_8) {
        var_10 *= 2;
      }

      thread getsquadspawnlocations(self, var_7, var_10);

      if(true) {
        if(var_8) {
          var_9 = self getweaponammoclip(var_7, "left") + self getweaponammoclip(var_7, "right");
          var_4 = self getweaponammostock(var_7);
          var_11 = var_9 + var_4;
          var_12 = int(min(getspecialdaystickers(var_7, var_11), var_11 + var_10));
          self setweaponammostock(var_7, var_12);
          self setweaponammoclip(var_7, 0, "left");
          self setweaponammoclip(var_7, 0, "right");
        } else {
          var_10 = self getweaponammoclip(var_8);
          var_5 = self getweaponammostock(var_8);
          var_11 = var_10 + var_5;
          var_13 = getspecialdaystickers(var_8, var_11);
          var_14 = var_11 + var_11;
          var_6 = int(var_14 - var_13);
          var_15 = int(min(var_13, var_14));

          if(var_8.basename == "iw8_lm_dblmg_mp") {
            self setweaponammoclip(var_8, var_10 + var_11);
          } else {
            self setweaponammoclip(var_8, 0);

            if(scripts\mp\utility\game::getgametype() == "br") {
              var_16 = var_15 - var_5;
              scripts\mp\gametypes\br_weapons::delay_camera_normal(var_8, var_16);
            } else {
              self setweaponammostock(var_8, var_15);
            }
          }
        }
      }
    }
  }

  var_7 = undefined;
  var_9 = undefined;
  thread getteamplunder(var_1, var_5, var_6);
  return true;
}

function getspecialdaystickers(var_0, var_1) {
  var_2 = var_0.maxammo;

  if(var_1 > var_2) {
    var_2 = var_1;
  }

  return var_2;
}

function getsubgametype(var_0) {
  if(!self isalternatemode(var_0)) {
    return 1;
  }

  var_1 = var_0.underbarrel;
  return scripts\mp\weapons::turretoverridefunc(var_1);
}

function getstancetop(var_0) {
  switch (var_0.basename) {
    case "s4_me_axe_mp":
    case "s4_me_icepick_mp":
    case "iw8_lm_dblmg_mp":
    case "iw8_me_t9ballisticknife_mp":
    case "iw8_sm_t9nailgun_mp":
    case "iw8_fists_mp":
      return true;
  }

  return false;
}

function getteamplunder(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    if(self getcurrentprimaryweapon() != var_0) {
      break;
    }

    var_3 = self getweaponammoclip(var_0);

    if(var_3 > 0) {
      scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "nova_rounds_loaded");
      self setclientomnvar("ui_chemRounds", 1);

      if(var_2 > 0) {
        self setweaponammostock(var_0, var_1 + var_2);
      }

      break;
    }

    waitframe();
  }

  if(!scripts\mp\supers::issuperinuse()) {
    waitframe();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
    return;
  }
}

function getsquadspawnlocations(var_0, var_1, var_2) {
  var_3 = init_relic_steelballs(var_0, var_1, var_2);
  getsquadspawnStruct(var_0, var_3);
}

function init_relic_steelballs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.player = var_0;
  var_3.objweapon = var_1;
  var_3.rounds = var_2;
  var_3.gavehcr = 0;
  var_3.kills = 0;
  return var_3;
}

function getsquadspawnStruct(var_0, var_1) {
  if(!isDefined(var_0.showassassinationtargethud)) {
    var_0.showassassinationtargethud = [];
  }

  var_2 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_1.objweapon);
  var_3 = var_0.showassassinationtargethud[var_2];

  if(isDefined(var_3)) {
    thread getteamcontenders();
  }

  var_0.showassassinationtargethud[var_2] = var_1;
  thread getspawncamerablendtime();
  thread getspecialdaycamos();
  thread getspecialdaycosmetics();
  thread getspreadpelletspershot();
  thread getsetplundercountdatanosplash();
  thread getteamplunderhud();
  thread getteamscoreplacements();
  thread getscrapassistplayers();
}

function gettacroverspawns(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  var_3 = getspectatorsofplayer(var_1, var_2);

  if(isDefined(var_3)) {
    var_4 = init_relic_steelballs(var_3.player, var_3.objweapon, var_3.rounds);
    var_0.showassassinationtargethud = var_4;
    thread getteamcontenders();
    return;
  }
}

function getteamcarriedplunder(var_0, var_1, var_2) {
  var_3 = var_0.showassassinationtargethud;

  if(!isDefined(var_3)) {
    return;
  }

  if(!isDefined(var_3.player) || !var_3.player hasweapon(var_3.objweapon)) {
    return;
  }

  var_3.player = var_1;
  getsquadspawnStruct(var_1, var_3);
}

function getspectatorsofplayer(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  if(!isDefined(self.showassassinationtargethud)) {
    return undefined;
  }

  var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_0);
  return self.showassassinationtargethud[var_1];
}

function getsixthsensedirection() {
  self endon("death_or_disconnect");
  self cancelreload();
  wait 0.05;
  return true;
}

function getteamplunderhud() {
  self endon("chemicalRounds_removeHCR");
  self.player endon("disconnect");
  self.post_blockade_combat_logic = 0;

  while(self.player hasweapon(self.objweapon)) {
    if(getstartparachutespawnpoint(self.player getcurrentweapon())) {
      if(!self.post_blockade_combat_logic) {
        self.player scripts\mp\utility\perk::giveperk("specialty_chemrounds");
        self.player.should_take_damage = 1;
        self.player.ref_11ed4 = 1;
        self.post_blockade_combat_logic = 1;
        self.player setclientomnvar("ui_chemRounds", 1);
        thread getsearchparams();
        thread getscrapassistplayers();
      }
    } else if(self.post_blockade_combat_logic) {
      self.player scripts\mp\utility\perk::removeperk("specialty_chemrounds");
      self.player.should_take_damage = 0;
      thread ref_12be2();
      self.post_blockade_combat_logic = 0;
      self.player setclientomnvar("ui_chemRounds", 0);
    }

    self.player waittill("weapon_change");
  }

  thread getteamcontenders();
}

function getteamscoreplacements() {
  self endon("chemicalRounds_removeHCR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    self.player waittill("weapon_fired", var_0);

    if(getstartparachutespawnpoint(var_0)) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  if(isDefined(self)) {
    thread getteamfactionsfrommap(self.player);
    thread getteamcontenders();
    return;
  }
}

function getteamfactionsfrommap(var_0) {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }

  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(var_1 != "iw8_sn_crossbow" && var_1 != "iw8_sn_t9crossbow") {
    return;
  }

  self.waittill_trigger_player = 1;
  scripts\engine\utility::ref_143c0(2, "weapon_fired", "weapon_change");
  self.waittill_trigger_player = undefined;
}

function getteamcontenders() {
  self notify("chemicalRounds_removeHCR");

  if(isDefined(self.player)) {
    if(istrue(self.post_blockade_combat_logic)) {
      if(isDefined(self.player.perks["specialty_chemrounds"])) {
        self.player scripts\mp\utility\perk::removeperk("specialty_chemrounds");
      }

      self.player.should_take_damage = 0;
      thread ref_12be2();
      self.player setclientomnvar("ui_chemRounds", 0);
    }

    if(isDefined(self)) {
      getsolospawnStruct();
      return;
    }

    return;
  }
}

function getsuperrefforsuperextraweapon() {
  self notify("chemicalRounds_removeHCR");

  if(isDefined(self.player)) {
    getsolospawnStruct();
    return;
  }
}

function getsolospawnStruct() {
  if(isDefined(self.player.showassassinationtargethud)) {
    var_0 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(self.objweapon);
    var_1 = self.player.showassassinationtargethud[var_0];

    if(isDefined(var_1) && var_1 == self) {
      self.player.showassassinationtargethud[var_0] = undefined;
    }

    self.player scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_nova_box", self.kills);
    self.player setclientomnvar("ui_chemRounds", 0);
    self.player.should_take_damage = 0;
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.player, level.superglobals.staticsuperdata["super_nova_box"].id, self.kills, 0);
    return;
  }
}

function getstartparachutespawnpoint(var_0) {
  var_1 = self.player getammotype(self.objweapon);
  var_2 = self.player getammotype(var_0);
  var_3 = var_1 == var_2;
  return isnullweapon(var_0, self.objweapon, 1) && var_3;
}

function getspawncamerablendtime() {
  self.player endon("disconnect");
  self endon("chemicalRounds_removeHCR");
  self.player waittill("death");
  thread getteamcontenders();
}

function getspecialdaycamos() {
  self.player endon("disconnect");
  self endon("chemicalRounds_removeHCR");
  level waittill("game_ended");
  thread getteamcontenders();
}

function getspecialdaycosmetics() {
  self.player endon("disconnect");
  self endon("chemicalRounds_removeHCR");
  self.player waittill("all_perks_cleared");
  thread getsuperrefforsuperextraweapon();
}

function getspreadpelletspershot() {
  self.player endon("death_or_disconnect");
  self.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  self.player scripts\engine\utility::ref_143a6("weapon_fired", "weapon_change", "chemicalRounds_removeHCR");
  self.player scripts\mp\utility\perk::removeperk("specialty_fastreload");
}

function getsetplundercountdatanosplash() {
  self endon("death_or_disconnect");
  scripts\common\utility::allow_sprint(0);
  wait 0.4;
  scripts\common\utility::allow_sprint(1);
}

function is_player_visible_to_trigger(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var_3 = vectorcross(vectorNormalize(var_0.origin - var_1.origin), anglestoup(var_1.angles));
  var_4 = var_1 getEye();
  var_5 = var_0.origin + (0, 0, level.getserverroomspawnpoint.gas_cloud_height / 2);
  var_6 = [];
  var_6[0] = var_4 + var_3 * 20;
  var_6[1] = var_4 - var_3 * 20;

  foreach(var_8 in var_6) {
    var_9 = physics_raycast(var_5, var_8, var_2, undefined, 0, "physicsquery_closest", 1);

    if(!(isDefined(var_9) && var_9.size > 0))
      return 1;

    waitframe();
  }

  return 0;
}