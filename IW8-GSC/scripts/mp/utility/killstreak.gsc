/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\killstreak.gsc
***********************************************/

function hasplayerdiedwhileusingkillstreak(var0) {
  return var0.lifeid != scripts\cp_mp\utility\killstreak_utility::getcurrentplayerlifeidforkillstreak();
}

function addtoactivekillstreaklist(var0, var1, var2, var3, var4, var5, var6) {
  var7 = self getentitynumber();
  self.activeid = getactivekillstreakid(var2);

  if(isDefined(var0)) {
    if(isremotekillstreak(var0)) {
      addtoremotekillstreaklist(var7);
      thread removefromremotekillstreaklistondeath(var7);
    }

    if(isuavkillstreak(var0)) {
      addtouavlist(var7, var2);
      thread removefromuavlistondeath(var7, var2);
    } else if(isairstrikekillstreak(var0)) {
      addtoairstrikelist(var7);
      thread removefromairstrikelistondeath(var7);
    } else if(islittlebirdkillstreak(var0)) {
      addtolittlebirdlist(var7);
      thread removefromlittlebirdlistondeath(var7);
    } else if(ishelikillstreak(var0)) {
      addtohelilist(var7);
      thread removefromhelilistondeath(var7);
    } else if(isturretkillstreak(var0)) {
      addtoturretlist(var7);
      thread removefromturretlistondeathorcarry(var7);
    } else if(iscarrykillstreak(var0)) {
      addtocarrylist(var7);
      thread removefromcarrylistondeathorcarry(var7);
    } else if(isprojectilekillstreak(var0)) {
      addtoprojectilelist(var7);
      thread removefromprojectilelistondeath(var7);
    } else if(issupportdronekillstreak(var0)) {
      addtosupportdronelist(var7);
      thread removefromsupportdronelistondeath(var7);
    } else if(isassaultdronekillstreak(var0)) {
      addtoassaultdronelist(var7);
      thread removefromassaultdronelistondeath(var7);
    } else {
      addtoplayerkillstreaklist(var7);
      thread removefromplayerkillstreaklistondeath(var7);
    }

    if(iskillstreaklockonable(var0)) {
      self.affectedbylockon = 1;
    }
  }

  level.activekillstreaks[var7] = self;
  level.activekillstreaks[var7].streakname = var0;

  if(var1 == "Killstreak_Air") {
    self.isairkillstreak = 1;

    if(!isDefined(var0) || var0 != "directional_uav" && var0 != "harp") {
      self enableplayermarks("air_killstreak");
    }
  } else {
    self.isairkillstreak = 0;
    self enableplayermarks("killstreak");
  }

  if(level.teambased) {
    self filteroutplayermarks(var2.team);
  } else {
    self filteroutplayermarks(var2);
  }

  if(istrue(var3)) {
    var8 = undefined;
    var9 = undefined;

    if(level.teambased) {
      if(scripts\cp_mp\utility\killstreak_utility::isridekillstreak(var0)) {
        foreach(var11 in level.players) {
          if(var11.team == self.team && var11 != self.owner) {
            var8 = scripts\mp\utility\outline::outlineenableforplayer(self, var11, "outline_nodepth_cyan", "lowest");
          }

          if(isDefined(var8)) {
            thread removeoutlineonnotify(var8, var6);
          }
        }

        var9 = 1;
      } else {
        var8 = scripts\mp\utility\outline::outlineenableforteam(self, var2.team, "outline_nodepth_cyan", "lowest");
      }
    } else {
      var8 = scripts\mp\utility\outline::outlineenableforplayer(self, var2, "outline_nodepth_cyan", "lowest");
    }

    if(!istrue(var9)) {
      thread removeoutlineonnotify(var8, var6);
    }
  }

  if(istrue(var4)) {
    var13 = 0;

    if(var2 scripts\mp\utility\player::isusingremote()) {
      var13 = 1;
    }

    var14 = undefined;

    if(level.teambased) {
      var14 = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var5, 1, 10000, undefined, undefined, 1, var13);
    } else {
      if(istrue(var13)) {
        return;
      }

      var14 = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var2, "hud_icon_head_equipment_friendly", var5, 1, 10000, undefined, undefined, 1);
    }

    thread removeteamheadicononnotify(var14, var6);
    return;
  }
}

function getactivekillstreakid() {
  if(!isDefined(self.pers["nextActiveID"])) {
    self.pers["nextActiveID"] = 0;
  }

  var0 = self.pers["nextActiveID"];
  self.pers["nextActiveID"]++;
  return var0;
}

function removeoutlineonnotify(var0, var1) {
  var2 = ["death"];

  if(isDefined(var1)) {
    GscBinSkip0(0x2e, var2.size, var1);
  }

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var2);
  scripts\mp\utility\outline::outlinedisable(var0, self);
}

function removeteamheadicononnotify(var0, var1) {
  var2 = ["death"];

  if(isDefined(var1)) {
    GscBinSkip0(0x2e, var2.size, var1);
  }

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var2);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var0);
}

function removefromactivekillstreaklist(var0) {
  level.activekillstreaks[var0] = undefined;
}

function activekillstreaklistcontains(var0) {
  if(!isDefined(level.activekillstreaks)) {
    return false;
  }

  return isDefined(level.activekillstreaks[var0]);
}

function addtoremotekillstreaklist(var0) {
  if(!isDefined(level.remotekillstreaks)) {
    level.remotekillstreaks = [];
  }

  level.remotekillstreaks[var0] = self;
}

function removefromremotekillstreaklistondeath(var0) {
  self waittill("death");
  level.remotekillstreaks[var0] = undefined;
}

function addtouavlist(var0, var1) {
  if(!isDefined(level.uavmodels)) {
    level.uavmodels = [];
  }

  if(level.teambased) {
    var2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
      var2 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
    }

    if(istrue(var2) && getdvarint("scr_uav_for_squad_only", 1)) {
      var3 = var1.team + var1.squadindex;
      level.uavmodels[var3][level.uavmodels[var3].size] = self;
      return;
    }

    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
    return;
  }

  level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

function removefromuavlistondeath(var0, var1) {
  self waittill("death");

  if(isDefined(self.uavrig)) {
    self.uavrig delete();
  }

  if(level.teambased) {
    var2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
      var2 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
    }

    if(istrue(var2) && getdvarint("scr_uav_for_squad_only", 1)) {
      var3 = var1.team + var1.squadindex;
      level.uavmodels[var3] = scripts\engine\utility::array_removeundefined(level.uavmodels[var3]);
    } else {
      level.uavmodels[self.team] = scripts\engine\utility::array_removeundefined(level.uavmodels[self.team]);
    }
  } else {
    level.uavmodels = scripts\engine\utility::array_removeundefined(level.uavmodels);
  }

  if(isDefined(self)) {
    self delete();
  }

  removefromactivekillstreaklist(var0);
}

function addtoairstrikelist(var0) {
  if(!isDefined(level.airstrikemodels)) {
    level.airstrikemodels = [];
  }

  level.airstrikemodels[var0] = self;
}

function removefromairstrikelistondeath(var0) {
  self waittill("death");
  level.airstrikemodels[var0] = undefined;
  removefromactivekillstreaklist(var0);
}

function addtolittlebirdlist(var0) {
  if(!isDefined(level.littlebirds)) {
    level.littlebirds = [];
  }

  level.littlebirds[var0] = self;
}

function removefromlittlebirdlistondeath(var0) {
  self waittill("death");
  level.littlebirds[var0] = undefined;
  removefromactivekillstreaklist(var0);
}

function addtohelilist(var0) {
  if(!isDefined(level.helis)) {
    level.helis = [];
  }

  level.helis[var0] = self;
}

function removefromhelilist(var0) {
  level.helis[var0] = undefined;
  removefromactivekillstreaklist(var0);
}

function removefromhelilistondeath(var0) {
  self waittill("death");
  level.helis[var0] = undefined;
  removefromactivekillstreaklist(var0);
}

function addtoturretlist(var0) {
  if(!isDefined(level.turrets)) {
    level.turrets = [];
  }

  level.turrets[var0] = self;
}

function removefromturretlistondeathorcarry(var0) {
  scripts\engine\utility::ref_143a5("death", "carried");
  level.turrets[var0] = undefined;
  removefromactivekillstreaklist(var0);
}

function addtocarrylist(var0) {
  if(!isDefined(level.deployables)) {
    level.deployables = [];
  }

  level.deployables[var0] = self;
}

function removefromcarrylistondeathorcarry(var0) {
  scripts\engine\utility::ref_143a5("death", "carried");
  level.deployables[var0] = undefined;
  removefromactivekillstreaklist(var0);
}

function addtosupportdronelist(var0) {
  if(!isDefined(level.supportdrones)) {
    level.supportdrones = [];
  }

  level.supportdrones[var0] = self;
}

function removefromsupportdronelistondeath(var0) {
  self waittill("death");
  level.supportdrones[var0] = undefined;
  removefromactivekillstreaklist(var0);
}

function addtoassaultdronelist(var0) {
  if(!isDefined(level.assaultdrones)) {
    level.assaultdrones = [];
  }

  level.assaultdrones[var0] = self;
}

function removefromassaultdronelistondeath(var0) {
  self waittill("death");
  level.assaultdrones[var0] = undefined;
  removefromactivekillstreaklist(var0);
}

function addtoprojectilelist(var0) {
  if(!isDefined(level.projectilekillstreaks)) {
    level.projectilekillstreaks = [];
  }

  level.projectilekillstreaks[var0] = self;
}

function removefromprojectilelistondeath(var0) {
  self waittill("death");
  level.projectilekillstreaks[var0] = undefined;
  removefromactivekillstreaklist(var0);
}

function addtoplayerkillstreaklist(var0) {
  if(!isDefined(level.playerkillstreaks)) {
    level.playerkillstreaks = [];
  }

  level.playerkillstreaks[var0] = self;
}

function removefromplayerkillstreaklistondeath(var0) {
  self waittill("death");
  level.playerkillstreaks[var0] = undefined;
  removefromactivekillstreaklist(var0);
}

function setkillstreakcontrolpriority(var0, var1, var2, var3, var4, var5, var6, var7) {
  self makeusable();
  self setCursorHint("HINT_NOICON");
  self sethintonobstruction("show");
  self setHintString(var1);
  self sethintdisplayfov(var2);
  self setusefov(var3);
  self sethintdisplayrange(var4);
  self setuserange(var5);
  self setusepriority(1);
  thread applyplayercontrolonconnect(level);

  foreach(var9 in level.players) {
    if(var9 == var0 && !istrue(var7)) {
      self enableplayeruse(var9);
      continue;
    }

    self disableplayeruse(var9);
  }
}

function applyplayercontrolonconnect(var0) {
  var0 endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var1);
    var0 disableplayeruse(var1);
  }
}

function applykillstreakplayeroutline(var0, var1) {
  var2 = self.team;
  var3 = self.owner;
  var4 = undefined;
  var5 = undefined;

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive() || var0.team == "spectator" || var0.team == "follower") {
    return;
  }

  if(var0 == var3) {
    var4 = "outlinefill_depth_cyan";
  } else if(var0 != var3) {
    if(level.teambased && var0.team != var2 || !level.teambased) {
      var4 = "outlinefill_depth_orange";
      var5 = 1;
    } else {
      return;
    }
  }

  if(isDefined(var4)) {
    if(istrue(var5)) {
      if(var0 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
        return;
      }
    }

    var6 = scripts\mp\utility\outline::outlineenableforplayer(var0, self.owner, var4, "killstreak");
    thread watchoutlineremoveonkillstreakend(var6, var0, var1);
    thread watchoutlineremoveonplayerend(var6, var0, var1);
    return;
  }
}

function watchoutlineremoveonkillstreakend(var0, var1, var2) {
  var1 endon("death_or_disconnect");
  level endon("game_ended");
  self waittill(var2);
  scripts\mp\utility\outline::outlinedisable(var0, var1);
}

function watchoutlineremoveonplayerend(var0, var1, var2) {
  self endon(var2);
  level endon("game_ended");
  var1 waittill("death_or_disconnect");
  scripts\mp\utility\outline::outlinedisable(var0, var1);
}

function getmodifiedantikillstreakdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var3 = scripts\mp\damage::handleshotgundamage(var1, var2, var3);
  var3 = scripts\mp\damage::handleapdamage(var1, var2, var3, var0);
  var11 = var1.isalternatemode;
  var12 = 0;

  if(istrue(var11)) {
    var13 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var1);

    foreach(var15 in var13) {
      if(var15 == "gl") {
        var12 = 1;
        break;
      }
    }
  }

  var17 = undefined;

  if(var2 != "MOD_MELEE") {
    switch (var1.basename) {
      case "nuke_mp":
      case "cruise_proj_mp":
        self.largeprojectiledamage = 1;
        self.killoneshot = 1;
        var17 = 1;
        break;
      case "fuelstrike_proj_mp":
      case "at_mine_mp":
      case "apache_proj_mp":
      case "emp_drone_non_player_mp":
      case "assault_drone_mp":
      case "hover_jet_proj_mp":
      case "emp_drone_non_player_direct_mp":
      case "ac130_105mm_mp":
      case "iw8_la_t9standard_mp":
      case "iw8_la_gromeoks_mp":
      case "iw8_la_juliet_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_kgolf_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_t9freefire_mp":
      case "bradley_tow_proj_ks_mp":
      case "bradley_tow_proj_mp":
        self.largeprojectiledamage = 1;
        var17 = var5;
        break;
      case "hoopty_truck_mp":
      case "hoopty_mp":
      case "cop_car_mp":
      case "apc_rus_mp":
      case "cargo_truck_mp":
      case "atv_mp":
      case "lighttank_mp":
      case "white_phosphorus_proj_mp":
      case "emp_grenade_mp":
      case "ac130_40mm_mp":
      case "med_transport_mp":
      case "toma_proj_mp":
      case "big_bird_mp":
      case "motorcycle_mp":
      case "little_bird_mg_mp":
      case "van_mp":
      case "pickup_truck_mp":
      case "large_transport_mp":
      case "tac_rover_mp":
      case "little_bird_mp":
      case "cargo_truck_mg_mp":
      case "technical_mp":
      case "lighttank_tur_ks_mp":
      case "lighttank_tur_mp":
        self.largeprojectiledamage = 1;
        var17 = var6;
        break;
      case "semtex_mp":
      case "ac130_25mm_mp":
      case "artillery_mp":
      case "semtex_aalpha12_mp":
      case "semtex_xmike109_mp":
      case "semtex_bolt_mp":
      case "frag_grenade_mp":
      case "pac_sentry_turret_mp":
      case "claymore_mp":
      case "at_mine_ap_mp":
      case "c4_mp_p":
        self.largeprojectiledamage = 0;
        var17 = var7;
        break;
      case "thermite_bolt_radius_mp":
      case "thermite_xmike109_mp":
      case "thermite_bolt_mp":
      case "thermite_xmike109_radius_mp":
      case "thermite_av_mp":
        self.largeprojectiledamage = 0;
        var17 = var9;
        break;
    }
  } else {
    self.largeprojectiledamage = 0;
    var17 = var8;
  }

  if(isDefined(var10)) {
    self.largeprojectiledamage = var10;
  }

  if(isDefined(var17) && isDefined(var2) && (var2 == "MOD_EXPLOSIVE" || var2 == "MOD_EXPLOSIVE_BULLET" || var2 == "MOD_FIRE" || var2 == "MOD_PROJECTILE" || var2 == "MOD_PROJECTILE_SPLASH" || var2 == "MOD_GRENADE" || var2 == "MOD_GRENADE_SPLASH" || var2 == "MOD_MELEE")) {
    var3 = ceil(var4 / var17);
  }

  var18 = 0;

  if(isDefined(var0) && isDefined(self.owner) && !var18) {
    if(isDefined(var0.owner)) {
      var0 = var0.owner;
    }

    if(var0 == self.owner && !istrue(self.killoneshot)) {
      var3 = ceil(var3 / 2);
    }
  }

  return int(var3);
}

function isexplosiveantikillstreakweapon(var0) {
  var1 = 0;
  var2 = 0;

  if(isstring(var0)) {
    var2 = issubstr(var0, "alt_");
  } else if(issameweapon(var0)) {
    var2 = var0.isalternate;
  }

  var3 = 0;

  if(istrue(var2)) {
    var4 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var0);

    foreach(var6 in var4) {
      if(var6 == "gl") {
        var3 = 1;
        break;
      }
    }
  }

  var8 = scripts\mp\utility\weapon::getweaponbasenamescript(var0);

  switch (var8) {
    case "power_exploding_drone_mp":
    case "sentry_shock_missile_mp":
    case "kineticpulse_emp_mp":
    case "switch_blade_child_mp":
    case "jackal_cannon_mp":
    case "drone_hive_projectile_mp":
    case "emp_grenade_mp":
    case "pop_rocket_mp":
    case "artillery_mp":
    case "c4_mp_p":
    case "iw8_la_juliet_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_t9freefire_mp":
    case "super_trophy_mp":
      var1 = 1;
      break;
  }

  return var1;
}

function nulldamagecheck(var0) {
  return isDefined(var0) && var0 == self.owner;
}

function dodamagetokillstreak(var0, var1, var2, var3, var4, var5, var6) {
  var7 = (0, 0, 0);
  var8 = (0, 0, 0);
  var9 = (0, 0, 0);
  var10 = (0, 0, 0);
  var11 = "";
  var12 = "";
  var13 = "";
  var14 = undefined;

  if(isDefined(var3)) {
    if(level.teambased) {
      if(!scripts\mp\utility\entity::isvalidteamtarget(var1, var3, self)) {
        return;
      }
    } else if(!scripts\mp\utility\entity::isvalidffatarget(var1, var3, self)) {
      return;
    }
  }

  if(isagent(self)) {
    self dodamage(var0, var4, var1, var2, var5, var6);
    return;
  }

  if(scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    self dodamage(var0, var4, var1, var2, var5, var6);
    return;
  }

  var15 = asmdevgetallstates(var6);
  self notify("damage", var0, var1, var7, var8, var5, var11, var12, var13, var14, var15, var4, var9, var10, var2);
}

function playdlightfx(var0, var1) {
  self endon("death");

  if(!isDefined(var0)) {
    var0 = (0, 0, 0);
  }

  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  var2 = scripts\engine\utility::getfx("dlight_large");

  if(istrue(self.isairdrop)) {
    var2 = scripts\engine\utility::getfx("dlight_small");
  }

  self.fxdlightent = spawn("script_model", self.origin);
  self.fxdlightent setModel("tag_origin");
  self.fxdlightent linkTo(self, "tag_origin", var0, var1);
  thread deleteonparentdeath(self.fxdlightent);
  wait 0.1;
  playFXOnTag(var2, self.fxdlightent, "tag_origin");
}

function deleteonparentdeath(var0) {
  self endon("death");
  var0 waittill("death");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function isaffectedbyblindeye(var0) {
  switch (var0) {
    case "jackal":
    case "sentry_shock":
      return true;
  }

  return false;
}

function getplayerkillstreakcombatmode(var0) {
  var1 = "NONE";

  if(isDefined(var0.owner) && isDefined(var0.owner.currentcombatmode)) {
    var1 = var0.owner.currentcombatmode;
  }

  return var1;
}

function watchsupertrophynotify(var0) {
  var0 endon("disconnect");
  self endon("explode");

  for(;;) {
    var0 waittill("destroyed_by_trophy", var1, var2, var3, var4, var5);

    if(var3 != self.weapon_name) {
      continue;
    }

    var0 scripts\mp\damagefeedback::updatedamagefeedback("");
    break;
  }
}

function watchhostmigrationlifetime(var0, var1, var2) {
  if(var0 != "death") {
    self endon("death");
  }

  self endon(var0);
  level endon("game_ended");
  var3 = gettime() + int(var1 * 1000);
  level waittill("host_migration_begin");
  self notify("host_migration_lifetime_update");
  var4 = gettime();
  var5 = var3 - var4;
  level waittill("host_migration_end");
  var6 = gettime();
  var7 = var6 + var5;
  var5 /= 1000;

  if(isDefined(self.streakname) && scripts\cp_mp\utility\killstreak_utility::isridekillstreak(self.streakname)) {
    self.owner setclientomnvar("ui_killstreak_countdown", var7);
  }

  self[[var2]](var5);
}

function getenemytargets(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(var0 scripts\mp\utility\player::isenemy(var3)) {
      var1 = var3;
    }
  }

  return var1;
}

function _beginlocationselection(var0, var1, var2, var3) {
  self beginlocationselection(var1, var2, 0, var3);
  self.selectinglocation = 1;
  self setblurforplayer(10.3, 0.3);
  thread endselectiononaction("cancel_location");
  thread endselectiononaction("death");
  thread endselectiononaction("disconnect");
  thread endselectiononaction("used");
  thread endselectiononaction("weapon_change");
  self endon("stop_location_selection");
  thread endselectiononendgame();

  if(isDefined(var0) && self.team != "spectator" && self.team != "follower") {
    if(isDefined(self.streakmsg)) {
      self.streakmsg destroy();
    }

    if(self issplitscreenplayer()) {
      self.streakmsg = scripts\mp\hud_util::createfontstring("default", 1.3);
      self.streakmsg scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -98);
      return;
    }

    self.streakmsg = scripts\mp\hud_util::createfontstring("default", 1.6);
    self.streakmsg scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -190);
    return;
  }
}

function stoplocationselection(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "generic";
  }

  if(!var0) {
    self setblurforplayer(0, 0.3);
    self endlocationselection();
    self.selectinglocation = undefined;

    if(isDefined(self.streakmsg)) {
      self.streakmsg destroy();
    }
  }

  self notify("stop_location_selection", var1);
}

function endselectiononaction(var0) {
  self endon("stop_location_selection");
  self waittill(var0);
  thread stoplocationselection(var0 == "disconnect", var0);
}

function endselectiononendgame() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  thread stoplocationselection(0, "end_game");
}

function streakshouldchain(var0) {
  var1 = scripts\mp\killstreaks\killstreaks::calcstreakcost(var0);
  var2 = scripts\mp\killstreaks\killstreaks::getnextstreakname();
  var3 = scripts\mp\killstreaks\killstreaks::calcstreakcost(var2);
  return var1 < var3;
}

function streakcheckistargetindoors(var0, var1) {
  var2 = 0;
  var3 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(var0, var0 + (0, 0, 10000), var1, var3)) {
    var2 = 1;
  }

  return var2;
}

function validateusestreak(var0, var1) {
  if((!self isonground() || self iswallrunning()) && scripts\cp_mp\utility\killstreak_utility::isridekillstreak(var0)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/UNAVAILABLE");
    return false;
  }

  if(isDefined(self.selectinglocation)) {
    return false;
  }

  if(scripts\mp\utility\game::isairdenied()) {
    if(isflyingkillstreak(var0)) {
      if(!(isDefined(var1) && var1)) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_WHEN_AA");
      }

      return false;
    }
  }

  if(self isusingturret() && (scripts\cp_mp\utility\killstreak_utility::isridekillstreak(var0) || iscarrykillstreak(var0) || isturretkillstreak(var0))) {
    if(!(isDefined(var1) && var1)) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/UNAVAILABLE_USING_TURRET");
    }

    return false;
  }

  if(!scripts\common\utility::is_weapon_allowed()) {
    return false;
  }

  if(isDefined(level.civilianjetflyby) && isflyingkillstreak(var0)) {
    if(isDefined(var1) && var1) {}

    return false;
  }

  if(isDefined(var0) && var0 == "sentry_shock" && scripts\mp\arbitrary_up::isinarbitraryup()) {
    if(!(isDefined(var1) && var1)) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/UNAVAILABLE");
    }

    return false;
  }

  return true;
}

function isplayerkillstreak(var0) {
  if(!isDefined(var0.activeplayerstreak)) {
    return 0;
  }

  switch (var0.activeplayerstreak) {
    default:
      return 0;
  }
}

function iscarrykillstreak(var0) {
  switch (var0) {
    default:
      return 0;
  }
}

function isremotekillstreak(var0) {
  var1 = 0;

  switch (var0) {
    case "radar_drone_recon":
    case "assault_drone":
    case "gunship":
    case "chopper_gunner":
    case "cruise_predator":
    case "pac_sentry":
      var1 = 1;
      break;
  }

  return var1;
}

function isuavkillstreak(var0) {
  var1 = 0;

  switch (var0) {
    case "harp":
    case "counter_uav":
    case "directional_uav":
    case "uav":
      var1 = 1;
      break;
  }

  return var1;
}

function isairstrikekillstreak(var0) {
  var1 = 0;

  switch (var0) {
    case "multi_airstrike":
    case "white_phosphorus":
    case "hover_jet":
    case "gunship":
    case "fuel_airstrike":
    case "toma_strike":
    case "precision_airstrike":
      var1 = 1;
      break;
  }

  return var1;
}

function islittlebirdkillstreak(var0) {
  var1 = 0;

  switch (var0) {
    case "airdrop":
      var1 = 1;
      break;
  }

  return var1;
}

function ishelikillstreak(var0) {
  var1 = 0;

  switch (var0) {
    case "chopper_support":
    case "chopper_gunner":
      var1 = 1;
      break;
  }

  return var1;
}

function isballdronekillstreak(var0) {
  var1 = 0;
  return var1;
}

function isturretkillstreak(var0) {
  var1 = 0;

  switch (var0) {
    case "manual_turret":
      var1 = 1;
      break;
  }

  return var1;
}

function isprojectilekillstreak(var0) {
  var1 = 0;

  switch (var0) {
    case "cruise_predator":
      var1 = 1;
      break;
  }

  return var1;
}

function issupportdronekillstreak(var0) {
  var1 = 0;

  switch (var0) {
    case "scrambler_drone_escort":
    case "radar_drone_escort":
    case "radar_drone_recon":
    case "assault_drone":
    case "radar_drone_overwatch":
    case "scrambler_drone_guard":
      var1 = 1;
      break;
  }

  return var1;
}

function isassaultdronekillstreak(var0) {
  var1 = 0;

  switch (var0) {
    case "pac_sentry":
      var1 = 1;
      break;
  }

  return var1;
}

function iscarepackage(var0) {
  return isDefined(var0) && isDefined(var0.id) && var0.id == "care_package";
}

function isjuggernaut() {
  return istrue(self.isjuggernaut);
}

function isremotekillstreakweapon(var0) {
  var1 = 0;

  switch (var0) {
    case "ks_remote_bomber_mp":
    case "ks_remote_hack_mp":
    case "ks_assault_drone_mp":
    case "ks_remote_drone_mp":
    case "ks_remote_nuke_mp":
    case "ks_remote_map_mp":
    case "ks_remote_gunship_mp":
    case "ks_remote_device_mp":
      var1 = 1;
      break;
  }

  return var1;
}

function iskillstreaklockonable(var0) {
  switch (var0) {
    case "harp":
    case "directional_uav":
    case "cruise_predator":
      return 0;
    default:
      return 1;
  }
}

function isflyingkillstreak(var0) {
  switch (var0) {
    case "drone_hive":
    case "heli_pilot":
    case "airdrop_sentry_minigun":
    case "helicopter":
    case "airdrop_assault":
    case "airdrop":
    case "gunship":
    case "precision_airstrike":
      return 1;
    default:
      return 0;
  }
}

function getkillstreakindex(var0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var0]["index"];
}

function getkillstreakkills(var0) {
  var1 = "kills";

  if(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak") && var0 != "nuke") {
    var1 = "scoreCost";
  } else if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
    var1 = "supportCost";
  }

  return level.killstreakglobals.streaktable.tabledatabyref[var0][var1];
}

function getkillstreakenemyusedialogue(var0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var0]["enemyUseDialog"];
}

function getkillstreakaudioref(var0) {
  var1 = getkillstreakaudiorefoverride(var0);

  if(var1 != "") {
    return var1;
  }

  var2 = strtok(var0, "_");

  foreach(var4 in var2) {
    if(var1 == "") {
      var1 = var4;
      continue;
    }

    var1 += var4;
  }

  return var1;
}

function getkillstreakaudiorefoverride(var0) {
  var1 = "";

  switch (var0) {
    case "scrambler_drone":
      var1 = "scrambler";
      break;
    case "cruise_predator":
      var1 = "predator";
      break;
    case "toma_strike":
      var1 = "clusterstrike";
      break;
    case "precision_airstrike":
      var1 = "a10strike";
      break;
  }

  return var1;
}

function getkillstreakoverheadicon(var0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var0]["overheadIcon"];
}

function currentactivevehiclecount(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  var1 = var0;

  if(isDefined(level.helis)) {
    var1 += level.helis.size;
  }

  if(isDefined(level.littlebirds)) {
    var1 += level.littlebirds.size;
  }

  if(isDefined(level.ugvs)) {
    var1 += level.ugvs.size;
  }

  if(isDefined(level.bradley) && isDefined(level.bradley.vehicles)) {
    var1 += level.bradley.size;
  }

  if(isDefined(level.supportdrones)) {
    var1 += level.supportdrones.size;
  }

  if(isDefined(level.assaultdrones)) {
    var1 += level.assaultdrones.size;
  }

  return var1;
}

function maxvehiclesallowed() {
  return 8;
}

function fauxvehiclecount() {
  return level.fauxvehiclecount;
}

function incrementfauxvehiclecount(var0) {
  if(!isDefined(var0)) {
    level.fauxvehiclecount++;
    return;
  }

  level.fauxvehiclecount += var0;
}

function decrementfauxvehiclecount(var0) {
  if(!isDefined(var0)) {
    level.fauxvehiclecount--;
  } else {
    level.fauxvehiclecount -= var0;
  }

  if(level.fauxvehiclecount < 0) {
    level.fauxvehiclecount = 0;
    return;
  }
}

function isassaultkillstreak(var0) {
  switch (var0) {
    case "drone_hive":
    case "harp":
    case "directional_uav":
    case "uav":
      return 1;
    default:
      return 0;
  }
}

function isresourcekillstreak(var0) {
  switch (var0) {
    case "deployable_ammo":
    case "uav_3dping":
    case "aa_launcher":
    case "recon_agent":
    case "sam_turret":
    case "deployable_vest":
      return 1;
    default:
      return 0;
  }
}

function issupportkillstreak(var0) {
  switch (var0) {
    default:
      return 0;
  }
}

function isspecialistkillstreak(var0) {
  switch (var0) {
    default:
      return 0;
  }
}

function gethelipilotmeshoffset() {
  return (0, 0, 5000);
}

function gethelipilottraceoffset() {
  return (0, 0, 2500);
}

function isnavmeshkillstreak(var0) {
  var1 = 0;
  return var1;
}

function iscontrollingproxyagent() {
  var0 = 0;

  if(isDefined(self.playerproxyagent) && isalive(self.playerproxyagent)) {
    var0 = 1;
  }

  return var0;
}

function killshouldaddtokillstreak(var0) {
  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    return false;
  }

  return !scripts\mp\utility\weapon::iskillstreakweapon(var0.basename) && !scripts\mp\utility\points::update_objective_setmlgbackground(var0);
}

function iskillstreak(var0) {
  return getkillstreakindex(var0) != -1;
}

function getairdropcrates() {
  if(isDefined(level.cratedata)) {
    return level.cratedata.crates;
  }

  return [];
}

function getnumairdropcrates() {
  if(isDefined(level.cratedata)) {
    return level.cratedata.crates.size;
  }

  return 0;
}

function attackerinremotekillstreak() {
  if(!isDefined(self)) {
    return false;
  }

  if(isDefined(level.gunshipplayer) && self == level.gunshipplayer) {
    return true;
  }

  if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && self == level.chopper.gunner) {
    return true;
  }

  if(isDefined(self.using_remote_tank) && self.using_remote_tank) {
    return true;
  }

  return false;
}

function killstreak_make_vehicle(var0, var1, var2, var3, var4) {
  self.vehiclename = var0;
  self.scorepopup = var1;
  self.vodestroyed = var2;
  self.votimeout = var3;
  self.destroyedsplash = var4;
  self enableplayermarks("killstreak");

  if(level.teambased) {
    self filteroutplayermarks(self.team);
  } else {
    self filteroutplayermarks(self.owner);
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);
  scripts\mp\vehicles\damage::get_vehicle_mod_damage_data(var0, 1);
}

function killstreak_vehicle_callback_init() {
  if(!istrue(level.kscallbackinitcomplete)) {
    level.kscallbackinitcomplete = 1;
    level.kspremoddamagecallback = &killstreak_pre_mod_damage_callback;
    level.kspostmoddamagecallback = &killstreak_post_mod_damage_callback;
    level.ksdeathcallback = &killstreak_death_callback;
    return;
  }
}

function killstreak_pre_mod_damage_callback(var0) {
  var1 = var0.damage;
  var2 = var0.attacker;

  if(!istrue(self.killoneshot)) {
    if(isDefined(var2) && isDefined(self.owner) && var2 == self.owner) {
      var1 = int(ceil(var1 * 0.5));
    }

    var0.damage = var1;
  }

  var3 = 1;
  var4 = self.kspremoddamagecallback;

  if(isDefined(var4)) {
    var3 = self[[var4]](var0);
  }

  return var3;
}

function killstreak_post_mod_damage_callback(var0) {
  scripts\mp\killstreaks\killstreaks::killstreakhit(var0.attacker, var0.objweapon, self, var0.meansofdeath, var0.damage);
  var1 = 1;
  var2 = self.kspostmoddamagecallback;

  if(isDefined(var2)) {
    var1 = self[[var2]](var0);
  }

  return var1;
}

function killstreak_death_callback(var0) {
  scripts\mp\damage::onkillstreakkilled(self.streakname, var0.attacker, var0.objweapon, var0.meansofdeath, var0.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  var1 = 1;
  var2 = self.ksdeathcallback;

  if(isDefined(var2)) {
    var1 = self[[var2]](var0);
  }

  return var1;
}

function killstreak_set_pre_mod_damage_callback(var0, var1) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(var0, level.kspremoddamagecallback);
  self.kspremoddamagecallback = var1;
}

function killstreak_set_post_mod_damage_callback(var0, var1) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(var0, level.kspostmoddamagecallback);
  self.kspostmoddamagecallback = var1;
}

function killstreak_set_death_callback(var0, var1) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_death_callback(var0, level.ksdeathcallback);
  self.ksdeathcallback = var1;
}

function getkillstreaknamefromweapon(var0) {
  var1 = var0.basename;

  if(isDefined(level.killstreakweaponmap[var1])) {
    return level.killstreakweaponmap[var1];
  }

  return undefined;
}