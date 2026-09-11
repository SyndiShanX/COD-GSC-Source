/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\juggernaut.gsc
***********************************************/

function init() {
  level.activejuggernauts = [];
  level.ref_11b5f = getdvarint("scr_ks_jugg_team_max", 0);
}

function jugg_makejuggernaut(var0, var1) {
  var2 = vehicle_damage_setweaponhitdamagedata(var0);

  if(!isDefined(var2)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BECOME");
    return false;
  }

  var3 = var2 != self getstance();
  self.isjuggernaut = 1;
  scripts\mp\battlechatter_mp::disablebattlechatter(self);
  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
  var4 = spawnStruct();
  var4.juggconfig = var0;
  var4.prevhealth = self.health;
  var4.prevmaxhealth = self.maxhealth;
  var4.prevbody = self getcustomizationbody();
  var4.prevhead = self getcustomizationhead();
  var4.prevviewmodel = self getcustomizationviewmodel();
  var4.prevspeedscale = self.playerstreakspeedscale;
  var4.prevsuit = self.suit;
  var4.prevclothtype = self.clothtype;
  var4.maskomnvar = "ui_gas_mask_juggernaut";
  self.maxhealth = var0.maxhealth;
  self.health = var0.startinghealth;
  scripts\mp\weapons::savetogglescopestates();
  scripts\mp\weapons::savealtstates();

  if(isDefined(level.headiconbox)) {
    self[[level.headiconbox]]();
  }

  if(isDefined(var0.classstruct)) {
    var5 = scripts\mp\class::respawnitems_saveplayeritemstostruct();
    var4.respawnitems = var5;
    var4.prevclass = self.lastclass;
    var4.prevclassstruct = self.classstruct;
    scripts\mp\class::loadout_updateclass(var0.classstruct, "juggernaut");
    scripts\mp\class::preloadandqueueclassstruct(var0.classstruct, 1, 1);
    scripts\mp\class::giveloadout(self.team, "juggernaut", 0, 1);
  }

  self.lastdroppableweaponobj = undefined;

  foreach(var7 in var0.perks) {
    scripts\mp\utility\perk::giveperk(var8);
  }

  if(istrue(self.ref_12346)) {
    scripts\mp\playeractions::allowactionset("fakeJugg", 1);
    self.ref_12346 = undefined;
  }

  jugg_toggleallows(var0.allows, 0);
  self skydive_setbasejumpingstatus(0);
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  jugg_setModel();
  self.playerstreakspeedscale = var0.movespeedscalar;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\player::_setsuit(var0.suit);
  self setclothtype(var0.clothtype);
  jugg_enableoverlay(var4);
  self.juggcontext = var4;

  if(var0.infiniteammo) {
    thread scripts\mp\utility\weapon::infiniteammothread(var0.infiniteammoupdaterate);
  } else {
    var9 = self getweaponslistexclusives();

    foreach(var11 in var9) {
      self setweaponammoclip(var11, weaponclipsize(var11));

      if(vehicle_damage_registervisualpercentcallback()) {
        self givemaxammo(var11);
        thread vehicle_damage_updatestatemaxhealthvalues(var11);
      }
    }
  }

  self.streakinfo = var1;
  self notify("juggernaut_start");
  thread scripts\mp\gameobjects::onjuggernaut();
  thread vehicle_getturretbyweapon();
  thread jugg_watchmusictoggle();
  thread jugg_watchfordeath();
  thread jugg_watchforgameend();
  thread jugg_watchfordisconnect();
  thread vehicle_interact_initdev();
  thread vehicle_is_ambient();

  if(vehicle_damage_registerinstance()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
  }

  if(isDefined(level.battle_tracks_standingonvehicletimeout)) {
    self[[level.battle_tracks_standingonvehicletimeout]]();
  }

  if(var3) {
    self setstance(var2);
  }

  scripts\mp\healthoverlay::onexitdeathsdoor(1);
  vehicle_damage_onexitstatemedium();
  return true;
}

function jugg_removejuggernaut() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("juggernaut_end");
  var0 = self.juggcontext;
  var1 = var0.juggconfig;
  self.musicplaying = undefined;
  jugg_disableoverlay(var0);
  jugg_toggleallows(var1.allows, 1);

  if(scripts\mp\utility\player::isreallyalive(self)) {
    self.maxhealth = var0.prevmaxhealth;
    self.health = var0.prevhealth;
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

    if(isDefined(var1.classstruct)) {
      scripts\mp\class::respawnitems_assignrespawnitems(var0.respawnitems);
      scripts\mp\class::giveloadout(self.team, var0.prevclass, 0, 1, 1);
    }

    foreach(var3 in var1.perks) {
      scripts\mp\utility\perk::removeperk(var4);
    }
  }

  if(var1.infiniteammo) {
    scripts\mp\utility\weapon::stopinfiniteammothread();
  }

  jugg_restoremodel(var0);
  self.playerstreakspeedscale = var0.prevspeedscale;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\player::_setsuit(var0.prevsuit);
  self setclothtype(var0.prevclothtype);
  self setscriptablepartstate("juggernaut", "neutral", 0);
  self setscriptablepartstate("headVFX", "neutral", 0);

  if(vehicle_damage_registerinstance()) {
    self skydive_setbasejumpingstatus(0);
    self skydive_setdeploymentstatus(0);
  }

  self.isjuggernaut = 0;
  self.juggcontext = undefined;
  self.streakinfo = undefined;
  scripts\mp\battlechatter_mp::enablebattlechatter(self);
}

function jugg_createconfig(var0, var1) {
  var2 = spawnStruct();
  var2.maxhealth = 3000;
  var2.startinghealth = var2.maxhealth;
  var2.movespeedscalar = -0.2;
  var2.ref_11b7d = 5;

  if(level.gametype == "br") {
    var2.ref_11b7d = 3;
  }

  var2.forcetostand = 1;
  var3 = "iw8_juggernaut_mp";

  if(scripts\common\utility::iscp()) {
    var3 = "iw8_juggernaut_cp";
  }

  var2.suit = var3;
  var2.infiniteammo = 0;
  var2.infiniteammoupdaterate = undefined;
  var2.classstruct = jugg_getdefaultclassstruct();
  var2.allows = [];
  var2.allows["stick_kill"] = 1;
  var2.allows["health_regen"] = 1;
  var2.allows["one_hit_melee_victim"] = 1;
  var2.allows["flashed"] = 1;
  var2.allows["stunned"] = 1;
  var2.allows["prone"] = 1;
  var2.allows["equipment"] = 1;
  var2.allows["supers"] = 1;
  var2.allows["killstreaks"] = 1;
  var2.allows["slide"] = 1;
  var2.allows["weapon_pickup"] = 1;
  var2.allows["execution_victim"] = 1;
  var2.allows["cough_gesture"] = 1;
  var2.allows["offhand_throwback"] = 1;
  var2.perks = [];
  var2.perks["specialty_stun_resistance"] = 1;
  var2.perks["specialty_sharp_focus"] = 1;
  var2.perks["specialty_melee_resist"] = 1;
  var2.perks["specialty_blastshield"] = 1;
  var2.perks["specialty_armorpiercing"] = 1;
  return var2;
}

function jugg_toggleallows(var0, var1) {
  foreach(var4, var3 in var0) {
    if(var3) {
      var4 = tolower(var4);
      self thread[[level.allow_funcs[var4]]](var1, "juggernaut");
    }
  }

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(var1, "juggernaut");
    scripts\common\utility::allow_mount_side(var1, "juggernaut");
    return;
  }
}

function jugg_getdefaultclassstruct() {
  var0 = scripts\mp\class::loadout_getclassstruct();
  var0.loadoutarchetype = "archetype_assault";
  var0.loadoutprimary = "iw8_minigunksjugg_mp";
  var0.loadoutsecondary = "none";
  return var0;
}

function vehicle_getturretbyweapon() {
  if(vehicle_damage_registerdefaultvisuals()) {
    var0 = getdvarint("scr_jugg_event_models", 0);

    if(var0) {
      var1 = undefined;

      if(vehicle_damage_updatestate_br(var0)) {
        var1 = "flames";
      }

      if(isDefined(var1)) {
        self setscriptablepartstate("headVFX", var1, 0);
        return;
      }

      return;
    }

    return;
  }
}

function jugg_watchmusictoggle() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  var0 = 0;

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.name) && getdvarint("scr_br_alt_mode_zxp", 0)) {
    return;
  }

  if(!isbot(self) && !isagent(self)) {
    self notifyonplayercommand("toggle_music", "+actionslot 3");
    self notifyonplayercommand("toggle_music", "killstreak_wheel");
  }

  var1 = getcompleteweaponname("ks_gesture_jugg_music_mp");
  var2 = weaponfiretime(var1);

  if(!isDefined(self.musicplaying)) {
    var3 = self getjuggdefaultmusicenabled();
    self.musicplaying = var3;
  }

  if(!istrue(self.musicplaying)) {
    self setscriptablepartstate("juggernaut", "neutral", 0);
    goto LOC_000000c2;
  }

  self setscriptablepartstate("juggernaut", "music", 0);

  for(;;) {
    self waittill("toggle_music");

    if(self isonladder() || self ismantling()) {
      continue;
    }

    self giveandfireoffhand(var1);
    self playsoundonmovingent("mp_jugg_mus_toggle_foley");
    self playlocalsound("mp_jugg_mus_toggle_button");
    var4 = 0.2;

    if(istrue(self.musicplaying)) {
      var4 = 0.65;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var4);

    if(istrue(self.musicplaying)) {
      self.musicplaying = 0;
      self setscriptablepartstate("juggernaut", "neutral", 0);
    } else {
      self.musicplaying = 1;
      self setscriptablepartstate("juggernaut", "music", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.5);
  }
}

function jugg_watchfordeath() {
  self endon("juggernaut_end");
  self waittill("death");
  thread jugg_removejuggernaut();
}

function jugg_watchforgameend() {
  self endon("juggernaut_end");
  var0 = self.juggcontext;
  level waittill("game_ended");

  if(isDefined(self)) {
    self.maxhealth = var0.prevmaxhealth;
    self.health = var0.prevhealth;
    jugg_disableoverlay(var0);
    self setscriptablepartstate("juggernaut", "neutral", 0);
    return;
  }
}

function jugg_watchfordisconnect() {
  self endon("juggernaut_end");
  var0 = self.juggcontext;
  self waittill("disconnect");

  if(isDefined(self)) {
    self.maxhealth = var0.prevmaxhealth;
    self.health = var0.prevhealth;
    return;
  }
}

function vehicle_interact_initdev() {
  self endon("juggernaut_end");

  for(;;) {
    self waittill("weapon_fired");

    if(isDefined(self.streakinfo) && isDefined(self.streakinfo.shots_fired)) {
      self.streakinfo.shots_fired++;
    }
  }
}

function vehicle_damage_registerdefaultvisuals() {
  var0 = 0;
  var1 = getdvarint("scr_jugg_event_access", 0);

  if(scripts\mp\utility\game::matchmakinggame() || var1) {
    var0 = 1;
  }

  return var0;
}

function jugg_getjuggmodels() {
  var0 = [];
  GscBinSkip0(0x2e, "body", "body_opforce_juggernaut_mp_lod1");
}

function jugg_setModel() {
  var0 = jugg_getjuggmodels();

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  var1 = var0["body"];
  var2 = var0["head"];
  var3 = var0["view"];
  self setModel(var1);
  self setviewmodel(var3);
  self attach(var2, "", 1);
  self.headmodel = var2;
}

function jugg_restoremodel(var0) {
  self.operatorcustomization = undefined;

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self setcustomization(var0.prevbody, var0.prevhead);
    scripts\mp\teams::setcharactermodels(var0.prevbody, var0.prevhead, var0.prevviewmodel);
    return;
  }
}

function vehicle_damage_setweaponhitdamagedata(var0) {
  var1 = undefined;
  var2 = self getstance();

  if(var2 != "stand") {
    var3 = !istrue(var0.forcetostand) && !isDefined(var0.allows["crouch"]) || istrue(var0.allowcrouch);
    var4 = !istrue(var0.forcetostand) && !isDefined(var0.allows["prone"]) || istrue(var0.allowprone);
    var5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 0);

    if(!var3 && !var4) {
      var1 = "stand";
    } else if(var2 == "crouch") {
      if(!var3) {
        var6 = scripts\engine\trace::ray_trace_passed(self.origin, scripts\mp\utility\player::round_smoke_logic("stand"), self, var5);

        if(var6) {
          var1 = "stand";
        }
      } else {
        var1 = "crouch";
      }
    } else if(var2 == "prone") {
      if(!var4) {
        if(var3) {
          var7 = scripts\engine\trace::ray_trace_passed(self.origin, scripts\mp\utility\player::round_smoke_logic("crouch"), self, var5);

          if(var7) {
            var1 = "crouch";
          }
        } else {
          var6 = scripts\engine\trace::ray_trace_passed(self.origin, scripts\mp\utility\player::round_smoke_logic("stand"), self, var5);

          if(var6) {
            var1 = "stand";
          }
        }
      } else {
        var1 = "prone";
      }
    }
  } else {
    var1 = "stand";
  }

  return var1;
}

function jugg_enableoverlay(var0) {
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "mask_on");
  self setclientomnvar(var0.maskomnvar, 1);
  self.juggoverlaystatelabel = "mask_on";
  self.juggoverlaystate = 1;
  thread jugg_watchoverlaydamagestates(var0);
  thread jugg_watchforoverlayexecutiontoggle(var0);
}

function jugg_watchoverlaydamagestates(var0) {
  self endon("juggernaut_end");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var1 = self.health;
  var2 = var1 - var1 * 0.1;
  var3 = var1 - var1 * 0.35;
  var4 = var1 - var1 * 0.6;
  var5 = var1 - var1 * 0.85;
  var6 = 1;
  var7 = var6;
  var8 = "mask_on";

  for(;;) {
    scripts\engine\utility::ref_143a5("damage", "jugg_health_regen");

    if(self.health <= var5) {
      var8 = "mask_damage_critical";
      var6 = 5;
    } else if(self.health <= var4) {
      var8 = "mask_damage_high";
      var6 = 4;
    } else if(self.health <= var3) {
      var8 = "mask_damage_med";
      var6 = 3;
    } else if(self.health <= var2) {
      var8 = "mask_damage_low";
      var6 = 2;
    } else {
      var8 = "mask_on";
      var6 = 1;
    }

    if(var7 != var6) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", var8);
      self setclientomnvar(var0.maskomnvar, var6);
      var7 = var6;
      self.juggoverlaystatelabel = var8;
      self.juggoverlaystate = var6;
    }
  }
}

function jugg_watchforoverlayexecutiontoggle(var0) {
  self endon("juggernaut_end");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var1 = 0;

  for(;;) {
    if(!self isinexecutionattack()) {
      if(istrue(var1)) {
        scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.juggoverlaystatelabel);
        self setclientomnvar(var0.maskomnvar, self.juggoverlaystate);
        var1 = 0;
      }

      waitframe();
      continue;
    }

    if(!istrue(var1)) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
      self setclientomnvar(var0.maskomnvar, -1);
      var1 = 1;
    }

    waitframe();
  }
}

function jugg_disableoverlay(var0) {
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
  self setclientomnvar(var0.maskomnvar, 0);
  self.juggoverlaystatelabel = undefined;
  self.juggoverlaystate = undefined;
}

function jugg_getmovespeedscalar() {
  return -0.2;
}

function vehicle_damage_setweaponclassmoddamageforvehicle() {
  return self.juggcontext.juggconfig.classstruct.loadoutprimary;
}

function vehicle_damage_registervisualpercentcallback() {
  return istrue(self.juggcontext.juggconfig.ref_14092);
}

function vehicle_damage_setdeathcallback() {
  return istrue(self.juggcontext.juggconfig.ref_140a7);
}

function vehicle_damage_updatestatemaxhealthvalues(var0) {
  self endon("juggernaut_end");
  level endon("game_ended");
  var1 = self getweaponammostock(var0);
  thread vehicle_isenemytoplayer(var0, var1);
  thread vehicle_has_flare(var0, var1);

  for(;;) {
    self waittill("minigun_restock");
    self setweaponammostock(var0, var1);
  }
}

function vehicle_isenemytoplayer(var0, var1) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");

  for(;;) {
    if(self isbnetkr15player()) {
      var2 = self getweaponammostock(var0);

      if(var2 < var1) {
        self notify("minigun_restock");
      }
    }

    waitframe();
  }
}

function vehicle_has_flare(var0, var1) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");

  for(;;) {
    var2 = self getweaponammoclip(var0);

    if(var2 == 0) {
      var3 = self getweaponammostock(var0);

      if(var3 < var1) {
        self notify("minigun_restock");
      }
    }

    waitframe();
  }
}

function vehicle_damage_onexitstatemedium() {
  if(!isDefined(level.activejuggernauts)) {
    level.activejuggernauts = [];
  }

  level.activejuggernauts[level.activejuggernauts.size] = self;
  thread vehicle_invalid_seats();
}

function vehicle_invalid_seats() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(["juggernaut_end", "disconnect"]);
  vehicle_getteamfriendlyto();
}

function vehicle_getteamfriendlyto() {
  if(!isDefined(self)) {
    level.activejuggernauts = scripts\engine\utility::array_removeundefined(level.activejuggernauts);
    return;
  }

  level.activejuggernauts = scripts\engine\utility::array_remove(level.activejuggernauts, self);
}

function vehicle_is_ambient() {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  var0 = self.juggcontext.juggconfig;
  var0.spawn_all_unique_drones = 0;

  for(;;) {
    self waittill("perform_hero_drop");

    if(!istrue(var0.spawn_all_unique_drones)) {
      var0.spawn_all_unique_drones = 1;
      self radiusdamage(self.origin, 500, 2000, 500, self, "MOD_CRUSH");
      thread vehicle_getturrets(var0);
    }
  }
}

function vehicle_getturrets(var0) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  self setscriptablepartstate("heroDiveVfx", "on", 0);
  wait 1;
  self setscriptablepartstate("heroDiveVfx", "off", 0);
  var0.spawn_all_unique_drones = 0;
}

function vehicle_deletenextframe() {
  if(self isskydiving()) {
    self skydive_interrupt();
  }

  self notify("perform_hero_drop");
  return false;
}

function vehicle_deregister_on_death(var0, var1) {
  var2 = self.maxhealth;
  var3 = self.juggcontext.juggconfig;
  var4 = 0.5;
  var5 = 10;

  if(isDefined(var1) && isexplosivedamagemod(var1)) {
    var4 = 7;
    var5 = var3.ref_11b7d;
  }

  var6 = var0 * var4;
  var7 = var2 / var5;
  var8 = scripts\mp\utility\script::roundup(min(var7, var6));
  return int(var8);
}

function vehicle_deletenextframelate(var0) {
  return int(var0 / 2);
}

function vehicle_damage_registerinstance() {
  var0 = 0;
  var1 = 0;

  if(var1 || scripts\mp\utility\game::gametypesupportsbasejumping() && scripts\mp\utility\game::mapsupportsbasejumping()) {
    var0 = 1;
  }

  return var0;
}

function vehicle_damage_updatestate_br(var0) {
  return istrue(level.setplayerselfrevivingextrainfo) && var0 == 1;
}

function changecirclestateatlowtime() {
  if(istrue(level.ref_11b5f) && level.activejuggernauts.size > 0) {
    var0 = 0;
    var1 = level.activejuggernauts.size;

    for(var2 = 0; var2 < var1; var2++) {
      var3 = level.activejuggernauts[var2];

      if(isDefined(var3) && self.team == var3.team) {
        var0++;
      }
    }

    if(var0 >= level.ref_11b5f) {
      return true;
    }
  }

  return false;
}