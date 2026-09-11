/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58282.gsc
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
  level.getserverroomspawnpoint.¯Ê % AÖ op[é÷ SY² / þ > £bi¢ Wfh£ îì»³ % [º° + = getdvarfloat("scr_chem_rounds_gas_damage_per_tick_agent_multiplier", 5);
      level.getserverroomspawnpoint.plunder_clearrepositorywidgetforplayer = getdvarint("scr_chem_rounds_gas_cloud_size", 180);
      level.getserverroomspawnpoint.§R AöÃI z #§ b]° o« = getdvarint("scr_chem_rounds_gas_cloud_height", 96);
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

  function spawn_juggernauts_hangar(var0, var1, var2, var3) {
    if(istrue(var0.should_take_damage) || istrue(var0.waittill_trigger_player) || istrue(var3)) {
      if(isDefined(var1)) {
        if(isDefined(var2)) {
          var4 = easepower("vfx_chem_rounds_enemy_hit", var1);
          thread ref_12aab(var4);

          if(!istrue(var2.updateteamplunderscore)) {
            if(isPlayer(var2)) {
              stopfxontagforclients(level._effects["vfx_nova_round_scrnfx"], var2, "j_head", var2);
              playfxontagforclients(level._effects["vfx_nova_round_scrnfx"], var2, "j_head", var2);
            }

            var2.updateteamplunderscore = 1;

            if(isDefined(self)) {
              self playlocalsound("bullet_chem_round_dmg_plr_trans");
            }
          }

          thread ref_1447f(var2);
          return;
        }

        return;
      }

      return;
    }
  }

  function ref_12aab(var0) {
    level endon("game_ended");
    wait var0;
    self freescriptable();
  }

  function ref_1447f(var0, var1) {
    if(isPlayer(self) || isbot(self)) {
      self endon("disconnect");
    }

    level endon("game_ended");
    self notify("poisoned_watching_for_death");
    self endon("poisoned_watching_for_death");
    var2 = level.getserverroomspawnpoint.ref_127e0;

    if(isDefined(var1)) {
      var2 = var1;
    }

    if(var2 > 0) {
      var3 = scripts\engine\utility::ref_143b9(level.getserverroomspawnpoint.ref_127e0, "death");

      if(var3 == "timeout") {
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

    var4 = self.origin;
    var5 = easepower("super_nova_rounds_audio", var4);
    var6 = spawn("trigger_radius", var4, 0, level.getserverroomspawnpoint.plunder_clearrepositorywidgetforplayer, level.getserverroomspawnpoint.§R AöÃI z #§ b]° o«);
  var6.attacker = var0;
  waitframe();
  var7 = easepower("vfx_chem_rounds_enemy_death", var4);
  var5 setscriptablepartstate("sfx_gas_npc", "npc_gas_expl");
  scripts\mp\utility\trigger::makeenterexittrigger(var6, &ref_13dab, &ref_13dac, undefined, undefined, &ref_13da5);
  level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_add(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var6);
  wait level.getserverroomspawnpoint.plunder_awarded_by_missions_total;
  level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_remove(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var6);

  foreach(var9 in var6.triggerenterents) {
    if(getstreamedinplayercount(var9)) {
      var9 scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_rounds_gas");
    }
  }

  var5 freescriptable();
  var6 notify("gas_cloud_disipate");
  var7 freescriptable();
  var6 delete();
}

function playericonfilter(var0, var1, var2, var3) {
  var4 = easepower("super_nova_rounds_audio", var1);
  var4 setscriptablepartstate("sfx_weapon_chem", "sfx_weapon_chem_sweetner");
  var5 = scripts\engine\utility::ter_op(isDefined(var3), var3, level.getserverroomspawnpoint.§R AöÃI z #§ b]° o«);
var6 = spawn("trigger_radius", var1, 0, var5, var5);
var6.attacker = var0;
scripts\mp\utility\trigger::makeenterexittrigger(var6, &ref_13dab, &ref_13dac, undefined, undefined, &ref_13da5);
var7 = scripts\engine\utility::ter_op(isDefined(var2), var2, "vfx_chem_rounds_enemy_death");

if(isDefined(var2) && var2 == "nospawn") {
  var7 = "nospawn";
}

if(var7 != "nospawn") {
  var8 = easepower(var7, var1);
  thread ref_12aab(var8);
}

level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_add(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var6);
wait level.getserverroomspawnpoint.plunder_awarded_by_missions_total;
level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_remove(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var6);

foreach(var10 in var6.triggerenterents) {
  if(getstreamedinplayercount(var10)) {
    var10 scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_rounds_gas");
  }
}

var6 notify("gas_cloud_disipate");
var6 delete();
var4 freescriptable();
}

function ref_13dab(var0, var1) {
  thread ref_11c1d(var0);
}

function ref_13dac(var0, var1) {
  var0.start_coop_escape_safehouse = 0;
  var0 notify("out_of_poison_cloud");

  if(isPlayer(var0) && getstreamedinplayercount(var0)) {
    scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_rounds_gas");
    return;
  }
}

function ref_13da5(var0, var1) {
  if(!isDefined(var0)) {
    return true;
  }

  if(isPlayer(var0) || isbot(var0) || isagent(var0)) {
    return false;
  }

  return true;
}

function getstreamedinplayercount() {
  foreach(var1 in level.getserverroomspawnpoint.plunder_economy_shapshot_loop) {
    if(scripts\engine\utility::array_contains(var1.triggerenterents, self)) {
      return false;
    }
  }

  return true;
}

function ref_11c1d(var0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("gas_damage_watcher_triggered");
  self endon("gas_damage_watcher_triggered");
  var1 = 0;

  for(;;) {
    wait 0.5;

    if(!isDefined(var0)) {
      break;
    }

    if(!scripts\engine\utility::array_contains(var0.triggerenterents, self)) {
      break;
    }

    if(isDefined(var0.attacker) && isDefined(var0.attacker.team)) {
      if(self.team == var0.attacker.team && self != var0.attacker) {
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
      if(!is_player_visible_to_trigger(var0, self)) {
        continue;
      }

      if(istrue(level.brjugg_watchtimerstart) && self.health - level.getserverroomspawnpoint.plunder_getleveldataforrepository <= 0) {
        self.updateteamplunderscore = 1;
        thread ref_1447f(var0.attacker);
      }

      var2 = scripts\engine\utility::ter_op(isagent(self), level.getserverroomspawnpoint.¯Ê % AÖ op[é÷ SY² / þ > £bi¢ Wfh£ îì»³ % [º° + , 1); var3 = level.getserverroomspawnpoint.plunder_getleveldataforrepository * var2;

          if(scripts\mp\gametypes\br_public::hasarmor()) {
            scripts\mp\gametypes\br_public::damagearmor(var3);
          } else {
            var4 = var0.attacker;

            if(!isDefined(var0.attacker) || isDefined(var0.attacker.unittype) && var0.attacker.unittype == "zombie" && !isalive(var0.attacker)) {
              var4 = self;
            }

            self dodamage(var3, var0.origin, var4, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
          }

          if(isagent(self)) {
            var5 = easepower("vfx_chem_rounds_enemy_hit", self.origin + (0, 0, 50));
            thread ref_12aab(var5);
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
        self waittill("missile_fire", var0, var1);

        if(!istrue(self.ref_11ed4)) {
          return;
        }

        thread getserachparams(var0);
      }
    }

    function getscrapassistplayers() {
      self notify("watching_chem_projectile");
      self endon("watching_chem_projectile");
      self endon("stop_watching_chem_fire");
      level endon("game_ended");

      for(;;) {
        self waittill("grenade_fire", var0, var1);
        var2 = weaponinventorytype(var1.basename);

        if(var2 != "primary") {
          continue;
        }

        if(!istrue(self.ref_11ed4)) {
          return;
        }

        thread getserachparams(var0);
      }
    }

    function getserachparams(var0) {
      self waittill("explode", var1);
      thread playericonfilter(var0, var1);
      thread ref_13580(var0);
    }

    function ref_12be2() {
      wait 0.1;

      if(isDefined(self)) {
        self.ref_11ed4 = 0;
        self notify("stop_watching_chem_fire");
        return;
      }
    }

    function ref_13580(var0) {
      level endon("game_ended");
      var1 = spawn("script_model", var0);
      var1 setModel("tag_origin");
      waitframe();
      var1.ref_14293 = playFXOnTag(scripts\engine\utility::getfx("vfx_br3_canister_exp_large_chem"), var1, "tag_origin");
      var2 = 2;
      wait level.getserverroomspawnpoint.plunder_awarded_by_missions_total - var2;
      stopFXOnTag(scripts\engine\utility::getfx("vfx_br3_canister_exp_large_chem"), var1, "tag_origin");
      var1 delete();
    }

    function ref_11ed6() {
      var0 = self.lastweaponobj;
      var1 = isundefinedweapon();

      if(!scripts\mp\weapons::isnormallastweapon(var0) || scripts\mp\utility\weapon::ismeleeonly(var0) || scripts\mp\utility\weapon::isgamemodeweapon(var0) || scripts\mp\utility\weapon::isaxeweapon(var0) || !getsubgametype(var0) || getstancetop(var0)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPPORT_BOX_INCOMPAT");
        }

        return false;
      }

      self.should_take_damage = 1;
      self.ref_11ed4 = 1;
      thread getsearchparams();
      thread getscrapassistplayers();
      var2 = getsixthsensedirection();

      if(!istrue(var2)) {
        return false;
      }

      if(self isalternatemode(var0)) {
        var1 = var0;
        var0 = var0 getnoaltweapon();
      } else {
        var1 = var0 getaltweapon();
      }

      var3 = [];
      var4 = 0;
      var5 = 0;

      if(!nullweapon(var1)) {
        var3 = var1;
      }

      var3 = var0;

      foreach(var7 in var3) {
        var8 = scripts\mp\utility\weapon::turnexfiltoside(var7);

        if(isnullweapon(var7, var0, 0)) {
          var9 = scripts\mp\weapons::getammooverride(var7);
          var10 = var9 * 1;

          if(var8) {
            var10 *= 2;
          }

          thread getsquadspawnlocations(self, var7, var10);

          if(true) {
            if(var8) {
              var9 = self getweaponammoclip(var7, "left") + self getweaponammoclip(var7, "right");
              var4 = self getweaponammostock(var7);
              var11 = var9 + var4;
              var12 = int(min(getspecialdaystickers(var7, var11), var11 + var10));
              self setweaponammostock(var7, var12);
              self setweaponammoclip(var7, 0, "left");
              self setweaponammoclip(var7, 0, "right");
            } else {
              var10 = self getweaponammoclip(var8);
              var5 = self getweaponammostock(var8);
              var11 = var10 + var5;
              var13 = getspecialdaystickers(var8, var11);
              var14 = var11 + var11;
              var6 = int(var14 - var13);
              var15 = int(min(var13, var14));

              if(var8.basename == "iw8_lm_dblmg_mp") {
                self setweaponammoclip(var8, var10 + var11);
              } else {
                self setweaponammoclip(var8, 0);

                if(scripts\mp\utility\game::getgametype() == "br") {
                  var16 = var15 - var5;
                  scripts\mp\gametypes\br_weapons::delay_camera_normal(var8, var16);
                } else {
                  self setweaponammostock(var8, var15);
                }
              }
            }
          }
        }
      }

      var7 = undefined;
      var9 = undefined;
      thread getteamplunder(var1, var5, var6);
      return true;
    }

    function getspecialdaystickers(var0, var1) {
      var2 = var0.maxammo;

      if(var1 > var2) {
        var2 = var1;
      }

      return var2;
    }

    function getsubgametype(var0) {
      if(!self isalternatemode(var0)) {
        return 1;
      }

      var1 = var0.underbarrel;
      return scripts\mp\weapons::turretoverridefunc(var1);
    }

    function getstancetop(var0) {
      switch (var0.basename) {
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

    function getteamplunder(var0, var1, var2) {
      level endon("game_ended");
      self endon("death_or_disconnect");

      for(;;) {
        if(self getcurrentprimaryweapon() != var0) {
          break;
        }

        var3 = self getweaponammoclip(var0);

        if(var3 > 0) {
          scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "nova_rounds_loaded");
          self setclientomnvar("ui_chemRounds", 1);

          if(var2 > 0) {
            self setweaponammostock(var0, var1 + var2);
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

    function getsquadspawnlocations(var0, var1, var2) {
      var3 = init_relic_steelballs(var0, var1, var2);
      getsquadspawnStruct(var0, var3);
    }

    function init_relic_steelballs(var0, var1, var2) {
      var3 = spawnStruct();
      var3.player = var0;
      var3.objweapon = var1;
      var3.rounds = var2;
      var3.gavehcr = 0;
      var3.kills = 0;
      return var3;
    }

    function getsquadspawnStruct(var0, var1) {
      if(!isDefined(var0.showassassinationtargethud)) {
        var0.showassassinationtargethud = [];
      }

      var2 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var1.objweapon);
      var3 = var0.showassassinationtargethud[var2];

      if(isDefined(var3)) {
        thread getteamcontenders();
      }

      var0.showassassinationtargethud[var2] = var1;
      thread getspawncamerablendtime();
      thread getspecialdaycamos();
      thread getspecialdaycosmetics();
      thread getspreadpelletspershot();
      thread getsetplundercountdatanosplash();
      thread getteamplunderhud();
      thread getteamscoreplacements();
      thread getscrapassistplayers();
    }

    function gettacroverspawns(var0, var1, var2) {
      if(!isDefined(var0) || !isDefined(var1)) {
        return;
      }

      var3 = getspectatorsofplayer(var1, var2);

      if(isDefined(var3)) {
        var4 = init_relic_steelballs(var3.player, var3.objweapon, var3.rounds);
        var0.showassassinationtargethud = var4;
        thread getteamcontenders();
        return;
      }
    }

    function getteamcarriedplunder(var0, var1, var2) {
      var3 = var0.showassassinationtargethud;

      if(!isDefined(var3)) {
        return;
      }

      if(!isDefined(var3.player) || !var3.player hasweapon(var3.objweapon)) {
        return;
      }

      var3.player = var1;
      getsquadspawnStruct(var1, var3);
    }

    function getspectatorsofplayer(var0) {
      if(!isDefined(var0)) {
        return undefined;
      }

      if(!isDefined(self.showassassinationtargethud)) {
        return undefined;
      }

      var1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var0);
      return self.showassassinationtargethud[var1];
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
        self.player waittill("weapon_fired", var0);

        if(getstartparachutespawnpoint(var0)) {
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

    function getteamfactionsfrommap(var0) {
      self endon("disconnect");

      if(!isDefined(self)) {
        return;
      }

      var1 = scripts\mp\utility\weapon::getweaponrootname(var0);

      if(var1 != "iw8_sn_crossbow" && var1 != "iw8_sn_t9crossbow") {
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
        var0 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(self.objweapon);
        var1 = self.player.showassassinationtargethud[var0];

        if(isDefined(var1) && var1 == self) {
          self.player.showassassinationtargethud[var0] = undefined;
        }

        self.player scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_nova_box", self.kills);
        self.player setclientomnvar("ui_chemRounds", 0);
        self.player.should_take_damage = 0;
        scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.player, level.superglobals.staticsuperdata["super_nova_box"].id, self.kills, 0);
        return;
      }
    }

    function getstartparachutespawnpoint(var0) {
      var1 = self.player getammotype(self.objweapon);
      var2 = self.player getammotype(var0);
      var3 = var1 == var2;
      return isnullweapon(var0, self.objweapon, 1) && var3;
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

    function is_player_visible_to_trigger(var0, var1) {
      var2 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
      var3 = vectorcross(vectorNormalize(var0.origin - var1.origin), anglestoup(var1.angles));
      var4 = var1 getEye();
      var5 = var0.origin + (0, 0, level.getserverroomspawnpoint.§R AöÃI z #§ b]° o« / 2);
    var6 = [];
    GscBinSkip0(0x2e, 0, var4 + var3 * 20);
  }