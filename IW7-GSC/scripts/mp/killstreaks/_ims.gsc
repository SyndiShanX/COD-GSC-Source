/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_ims.gsc
*******************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("ims", ::func_128EA);
  level.var_9385 = [];
  var_0 = spawnStruct();
  var_0.var_39B = "ims_projectile_mp";
  var_0.modelbase = "ims_scorpion_body_iw6";
  var_0.modelplacement = "ims_scorpion_body_iw6_placement";
  var_0.modelplacementfailed = "ims_scorpion_body_iw6_placement_failed";
  var_0.modeldestroyed = "ims_scorpion_body_iw6";
  var_0.modelbombsquad = "ims_scorpion_body_iw6_bombsquad";
  var_0.pow = &"KILLSTREAKS_HINTS_IMS_PICKUP_TO_MOVE";
  var_0.placestring = &"KILLSTREAKS_HINTS_IMS_PLACE";
  var_0.cannotplacestring = &"KILLSTREAKS_HINTS_IMS_CANNOT_PLACE";
  var_0.streakname = "ims";
  var_0.var_10A38 = "used_ims";
  var_0.maxhealth = 670;
  var_0.lifespan = 90;
  var_0.var_DDAC = 0.5;
  var_0._meth_8487 = 0.4;
  var_0.var_C228 = 4;
  var_0.var_6A03 = "ims_scorpion_explosive_iw6";
  var_0.placementheighttolerance = 30;
  var_0.placementradius = 24;
  var_0.var_AC49 = "tag_lid";
  var_0.var_AC47 = [];
  var_0.var_AC47[1] = "IMS_Scorpion_door_1";
  var_0.var_AC47[2] = "IMS_Scorpion_door_2";
  var_0.var_AC47[3] = "IMS_Scorpion_door_3";
  var_0.var_AC47[4] = "IMS_Scorpion_door_4";
  var_0.var_AC48 = [];
  var_0.var_AC48[1] = "IMS_Scorpion_1_opened";
  var_0.var_AC48[2] = "IMS_Scorpion_2_opened";
  var_0.var_AC48[3] = "IMS_Scorpion_3_opened";
  var_0.var_6A09 = "tag_explosive";
  var_0.killcamoffset = (0, 0, 12);
  level.var_9385["ims"] = var_0;
  level._effect["ims_explode_mp"] = loadfx("vfx\iw7\_requests\mp\vfx_generic_equipment_exp_lg.vfx");
  level._effect["ims_smoke_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_damage_blacksmoke");
  level._effect["ims_sensor_explode"] = loadfx("vfx\core\mp\killstreaks\vfx_ims_sparks");
  level._effect["ims_antenna_light_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_light_detonator_blink");
  level.placedims = [];
}

func_128EA(var_0) {
  var_1 = [];
  if(isDefined(self.var_9382)) {
    var_1 = self.var_9382;
  }

  var_2 = setwaitspeed("ims", var_0);
  if(!isDefined(var_2)) {
    var_2 = 0;
    if(isDefined(self.var_9382)) {
      if(!var_1.size && self.var_9382.size) {
        var_2 = 1;
      }

      if(var_1.size && var_1[0] != self.var_9382[0]) {
        var_2 = 1;
      }
    }
  }

  if(var_2) {
    scripts\mp\matchdata::logkillstreakevent(var_0.streakname, self.origin);
  }

  self.iscarrying = 0;
  return var_2;
}

setwaitspeed(var_0, var_1) {
  var_2 = createimsforplayer(var_0, self);
  var_1.var_9380 = var_2;
  removeperks();
  self.carriedims = var_2;
  var_2.firstplacement = 1;
  var_3 = func_F684(var_2, 1);
  self.carriedims = undefined;
  thread restoreperks();
  return var_3;
}

func_F684(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 thread func_9377(self);
  scripts\engine\utility::allow_weapon(0);
  if(!isai(self)) {
    self notifyonplayercommand("place_ims", "+attack");
    self notifyonplayercommand("place_ims", "+attack_akimbo_accessible");
    if(!level.console) {
      self notifyonplayercommand("cancel_ims", "+actionslot 5");
      self notifyonplayercommand("cancel_ims", "+actionslot 6");
      self notifyonplayercommand("cancel_ims", "+actionslot 7");
    }
  }

  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_return("place_ims", "cancel_ims", "force_cancel_placement", "killstreak_trigger_blocked");
    if(var_2 == "cancel_ims" || var_2 == "force_cancel_placement" || var_2 == "killstreak_trigger_blocked") {
      if(!var_1 && var_2 == "cancel_ims" || var_2 == "killstreak_trigger_blocked") {
        continue;
      }

      var_0 ims_setcancelled(var_2 == "force_cancel_placement" && !isDefined(var_0.firstplacement));
      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }

    var_0 thread func_9379();
    self notify("IMS_placed");
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    scripts\mp\utility::_takeweapon("iw6_riotshield_mp");
  }
}

removeperks() {
  if(scripts\mp\utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility::removeperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\mp\utility::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  restoreperks();
}

createimsforplayer(var_0, var_1) {
  if(isDefined(var_1.iscarrying) && var_1.iscarrying) {
    return;
  }

  var_2 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_1.angles;
  var_2.var_9386 = var_0;
  var_2.triggerportableradarping = var_1;
  var_2 setModel(level.var_9385[var_0].modelbase);
  var_2 getvalidattachments();
  var_2 setturretmodechangewait(1);
  var_2 give_player_session_tokens("sentry_offline");
  var_2 makeunusable();
  var_2 setsentryowner(var_1);
  return var_2;
}

createims(var_0) {
  var_1 = var_0.triggerportableradarping;
  var_2 = var_0.var_9386;
  var_3 = spawn("script_model", var_0.origin);
  var_3 setModel(level.var_9385[var_2].modelbase);
  var_3.var_EB9C = 3;
  var_3.angles = var_0.angles;
  var_3.var_9386 = var_2;
  var_3.triggerportableradarping = var_1;
  var_3 setotherent(var_1);
  var_3.team = var_1.team;
  var_3.shouldsplash = 0;
  var_3.hidden = 0;
  var_3.var_252E = 1;
  var_3 getqacalloutalias();
  var_3.var_8BF0 = [];
  var_3.config = level.var_9385[var_2];
  var_3 thread func_9369();
  var_3 thread func_937C();
  var_3 thread func_9363();
  var_3 thread func_9372();
  return var_3;
}

func_9363() {
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 hide();
  var_0 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.triggerportableradarping);
  var_0 setModel(level.var_9385[self.var_9386].modelbombsquad);
  var_0 linkto(self);
  var_0 setcontents(0);
  self.bombsquadmodel = var_0;
  self waittill("death");
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_936D(var_0) {
  self.var_933C = 1;
  self notify("death");
}

func_9366() {
  self endon("carried");
  scripts\mp\damage::monitordamage(self.config.maxhealth, "ims", ::func_9368, ::func_936C, 1);
}

func_936C(var_0, var_1, var_2, var_3, var_4) {
  if(self.hidden || var_1 == "ims_projectile_mp") {
    return -1;
  }

  var_5 = var_3;
  if(var_2 == "MOD_MELEE") {
    var_5 = self.maxhealth * 0.25;
  }

  if(isexplosivedamagemod(var_2)) {
    var_5 = var_3 * 1.5;
  }

  var_5 = scripts\mp\damage::handlemissiledamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  return var_5;
}

func_9368(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\damage::onkillstreakkilled("ims", var_0, var_1, var_2, var_3, "destroyed_ims", "ims_destroyed");
  if(var_4) {
    var_0 notify("destroyed_equipment");
  }
}

func_9367() {
  self endon("carried");
  self waittill("death");
  func_E10B();
  if(!isDefined(self)) {
    return;
  }

  func_9378();
  self playSound("ims_destroyed");
  if(isDefined(self.inuseby)) {
    playFX(scripts\engine\utility::getfx("ims_explode_mp"), self.origin + (0, 0, 10));
    playFX(scripts\engine\utility::getfx("ims_smoke_mp"), self.origin);
    self.inuseby restoreperks();
    self.inuseby restoreweapons();
    self notify("deleting");
    wait(1);
  } else if(isDefined(self.var_933C)) {
    playFX(scripts\engine\utility::getfx("ims_explode_mp"), self.origin + (0, 0, 10));
    self notify("deleting");
  } else {
    playFX(scripts\engine\utility::getfx("ims_explode_mp"), self.origin + (0, 0, 10));
    playFX(scripts\engine\utility::getfx("ims_smoke_mp"), self.origin);
    wait(3);
    self playSound("ims_fire");
    self notify("deleting");
  }

  if(isDefined(self.objidfriendly)) {
    scripts\mp\objidpoolmanager::returnminimapid(self.objidfriendly);
  }

  if(isDefined(self.var_C2BA)) {
    scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BA);
  }

  scripts\mp\weapons::equipmentdeletevfx();
  self _meth_80D4();
  self delete();
}

watchempdamage() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    scripts\mp\weapons::stopblinkinglight();
    playFX(scripts\engine\utility::getfx("emp_stun"), self.origin);
    playFX(scripts\engine\utility::getfx("ims_smoke_mp"), self.origin);
    wait(var_1);
    func_937B();
  }
}

func_9369() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_0);
    if(!scripts\mp\utility::isreallyalive(var_0)) {
      continue;
    }

    if(self.var_E1 >= self.maxhealth) {
      continue;
    }

    var_1 = createimsforplayer(self.var_9386, var_0);
    if(!isDefined(var_1)) {
      continue;
    }

    var_1.var_935F = self;
    func_9378();
    func_936A();
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_0 func_F684(var_1, 0);
  }
}

func_9379() {
  self endon("death");
  level endon("game_ended");
  if(isDefined(self.carriedby)) {
    self.carriedby getrigindexfromarchetyperef();
  }

  self.carriedby = undefined;
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
  }

  self.firstplacement = undefined;
  var_0 = undefined;
  if(isDefined(self.var_935F)) {
    var_0 = self.var_935F;
    var_0 endon("death");
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0.carriedby = undefined;
    var_0 func_937A();
    if(isDefined(var_0.bombsquadmodel)) {
      var_0.bombsquadmodel show();
      var_0 func_9383(var_0.bombsquadmodel, 1);
      level notify("update_bombsquad");
    }
  } else {
    var_0 = createims(self);
  }

  var_0 func_184F();
  var_0.isplaced = 1;
  var_0 thread func_9366();
  var_0 thread watchempdamage();
  var_0 thread func_9367();
  var_0 setCanDamage(1);
  self playSound("ims_plant");
  self notify("placed");
  var_0 thread func_9375();
  var_1 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_1.linkparent = self.moving_platform;
  }

  var_1.endonstring = "carried";
  var_1.deathoverridecallback = ::func_936D;
  var_0 thread scripts\mp\movers::handle_moving_platforms(var_1);
  self delete();
}

ims_setcancelled(var_0) {
  if(isDefined(self.carriedby)) {
    var_1 = self.carriedby;
    var_1 getrigindexfromarchetyperef();
    var_1.iscarrying = undefined;
    var_1.carrieditem = undefined;
    var_1 scripts\engine\utility::allow_weapon(1);
    if(isDefined(var_1.var_9382)) {
      foreach(var_3 in var_1.var_9382) {
        if(isDefined(var_3.bombsquadmodel)) {
          var_3.bombsquadmodel delete();
        }
      }
    }
  }

  if(isDefined(var_0) && var_0) {
    scripts\mp\weapons::equipmentdeletevfx();
  }

  self delete();
}

func_9377(var_0) {
  func_E10B();
  self setModel(level.var_9385[self.var_9386].modelplacement);
  self setsentrycarrier(var_0);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread func_12EB0(self);
  thread func_936E(var_0);
  thread func_936F(var_0);
  thread func_9371();
  thread func_9370(var_0);
  self notify("carried");
  if(isDefined(self.var_935F)) {
    self.var_935F notify("carried");
    self.var_935F.carriedby = var_0;
    self.var_935F.isplaced = 0;
    if(isDefined(self.var_935F.bombsquadmodel)) {
      self.var_935F.bombsquadmodel hide();
    }
  }
}

func_12EB0(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("placed");
  var_0 endon("death");
  var_0.canbeplaced = 1;
  var_1 = -1;
  var_2 = level.var_9385[var_0.var_9386];
  for(;;) {
    var_3 = self canplayerplacesentry(1, var_2.placementradius);
    var_0.origin = var_3["origin"];
    var_0.angles = var_3["angles"];
    var_0.canbeplaced = self isonground() && var_3["result"] && abs(var_0.origin[2] - self.origin[2]) < var_2.placementheighttolerance;
    if(isDefined(var_3["entity"])) {
      var_0.moving_platform = var_3["entity"];
    } else {
      var_0.moving_platform = undefined;
    }

    if(var_0.canbeplaced != var_1) {
      if(var_0.canbeplaced) {
        var_0 setModel(level.var_9385[var_0.var_9386].modelplacement);
        self forceusehinton(level.var_9385[var_0.var_9386].placestring);
      } else {
        var_0 setModel(level.var_9385[var_0.var_9386].modelplacementfailed);
        self forceusehinton(level.var_9385[var_0.var_9386].cannotplacestring);
      }
    }

    var_1 = var_0.canbeplaced;
    wait(0.05);
  }
}

func_936E(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("death");
  if(self.canbeplaced && var_0.team != "spectator") {
    thread func_9379();
    return;
  }

  ims_setcancelled();
}

func_936F(var_0) {
  self endon("placed");
  self endon("death");
  var_0 waittill("disconnect");
  ims_setcancelled();
}

func_9370(var_0) {
  self endon("placed");
  self endon("death");
  for(;;) {
    if(isDefined(self.carriedby.onhelisniper) && self.carriedby.onhelisniper) {
      self notify("death");
    }

    wait(0.1);
  }
}

func_9371(var_0) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  ims_setcancelled();
}

func_9375() {
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.var_9385[self.var_9386].pow);
  var_0 = self.triggerportableradarping;
  var_0 getrigindexfromarchetyperef();
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 60));
  } else {
    scripts\mp\entityheadicons::setplayerheadicon(var_0, (0, 0, 60));
  }

  self makeusable();
  self setCanDamage(1);
  if(isDefined(var_0.var_9382)) {
    foreach(var_2 in var_0.var_9382) {
      if(var_2 == self) {
        continue;
      }

      var_2 notify("death");
    }
  }

  var_0.var_9382 = [];
  var_0.var_9382[0] = self;
  foreach(var_5 in level.players) {
    if(var_5 == var_0) {
      self enableplayeruse(var_5);
      continue;
    }

    self disableplayeruse(var_5);
  }

  if(self.shouldsplash) {
    level thread scripts\mp\utility::teamplayercardsplash(level.var_9385[self.var_9386].var_10A38, var_0);
    self.shouldsplash = 0;
  }

  var_7 = (0, 0, 20);
  var_8 = (0, 0, 256) - var_7;
  var_9 = [];
  self.var_A637 = [];
  for(var_0A = 0; var_0A < self.config.var_C228; var_0A++) {
    if(func_C229()) {
      var_0B = func_FCA8(var_0A + 1, self.config.var_C228 - 4);
    } else {
      var_0B = var_0A + 1;
    }

    var_0C = self gettagorigin(self.config.var_6A09 + var_0B + "_attach");
    var_0D = self gettagorigin(self.config.var_6A09 + var_0B + "_attach") + var_7;
    var_9[var_0A] = bulletTrace(var_0D, var_0D + var_8, 0, self);
    if(var_0A < 4) {
      var_0E = spawn("script_model", var_0C + self.config.killcamoffset);
      var_0E setscriptmoverkillcam("explosive");
      self.var_A637[self.var_A637.size] = var_0E;
    }
  }

  var_0F = var_9[0];
  for(var_0A = 0; var_0A < var_9.size; var_0A++) {
    if(var_9[var_0A]["position"][2] < var_0F["position"][2]) {
      var_0F = var_9[var_0A];
    }
  }

  self.var_2514 = var_0F["position"] - (0, 0, 20) - self.origin;
  var_10 = spawn("trigger_radius", self.origin, 0, 256, 100);
  self.var_2536 = var_10;
  self.var_2536 enablelinkto();
  self.var_2536 linkto(self);
  self.var_2528 = length(self.var_2514) / 200;
  func_937F();
  func_937B();
  thread func_937D();
  foreach(var_5 in level.players) {
    thread func_9374(var_5);
  }
}

func_937D() {
  self endon("death");
  for(;;) {
    level waittill("connected", var_0);
    func_9373(var_0);
  }
}

func_9373(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  self disableplayeruse(var_0);
}

func_9374(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  for(;;) {
    var_0 waittill("joined_team");
    self disableplayeruse(var_0);
  }
}

func_9372() {
  self endon("death");
  level endon("game_ended");
  self.triggerportableradarping waittill("killstreak_disowned");
  if(isDefined(self.isplaced)) {
    self notify("death");
    return;
  }

  ims_setcancelled(0);
}

func_937B() {
  thread scripts\mp\weapons::doblinkinglight("tag_fx");
  thread func_9362();
}

func_9378() {
  self makeunusable();
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
  } else if(isDefined(self.triggerportableradarping)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
  }

  if(isDefined(self.var_2536)) {
    self.var_2536 delete();
  }

  if(isDefined(self.var_A637)) {
    foreach(var_1 in self.var_A637) {
      if(isDefined(var_1)) {
        if(isDefined(self.triggerportableradarping) && isDefined(self.triggerportableradarping.var_9381) && var_1 == self.triggerportableradarping.var_9381) {
          continue;
        } else {
          var_1 delete();
        }
      }
    }
  }

  if(isDefined(self.var_69F6)) {
    self.var_69F6 delete();
    self.var_69F6 = undefined;
  }

  scripts\mp\weapons::stopblinkinglight();
}

isfriendlytoims(var_0) {
  if(level.teambased && self.team == var_0.team) {
    return 1;
  }

  return 0;
}

func_9362() {
  self endon("death");
  self endon("emp_damage");
  level endon("game_ended");
  for(;;) {
    if(!isDefined(self.var_2536)) {
      break;
    }

    self.var_2536 waittill("trigger", var_0);
    if(isplayer(var_0)) {
      if(isDefined(self.triggerportableradarping) && var_0 == self.triggerportableradarping) {
        continue;
      }

      if(level.teambased && var_0.pers["team"] == self.team) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_0)) {
        continue;
      }
    } else if(isDefined(var_0.triggerportableradarping)) {
      if(isDefined(self.triggerportableradarping) && var_0.triggerportableradarping == self.triggerportableradarping) {
        continue;
      }

      if(level.teambased && var_0.triggerportableradarping.pers["team"] == self.team) {
        continue;
      }
    }

    var_1 = var_0.origin + (0, 0, 50);
    if(!sighttracepassed(self.var_2514 + self.origin, var_1, 0, self)) {
      continue;
    }

    var_2 = 0;
    for(var_3 = 1; var_3 <= self.config.var_C228; var_3++) {
      if(var_3 > 4) {
        break;
      }

      if(sighttracepassed(self gettagorigin(self.config.var_AC49 + var_3), var_1, 0, self)) {
        var_2 = 1;
        break;
      }
    }

    if(!var_2) {
      continue;
    }

    self playSound("ims_trigger");
    scripts\mp\weapons::explosivetrigger(var_0, level.var_9385[self.var_9386]._meth_8487, "ims");
    if(!isDefined(self.var_2536)) {
      break;
    }

    if(!isDefined(self.var_8BF0[self.var_252E])) {
      self.var_8BF0[self.var_252E] = 1;
      thread func_6D2C(var_0, self.var_252E);
      self.var_252E++;
    }

    if(self.var_252E > self.config.var_C228) {
      break;
    }

    func_937F();
    self waittill("sensor_exploded");
    wait(self.config.var_DDAC);
    if(!isDefined(self.triggerportableradarping)) {
      break;
    }
  }

  if(isDefined(self.carriedby) && isDefined(self.triggerportableradarping) && self.carriedby == self.triggerportableradarping) {
    return;
  }

  self notify("death");
}

func_6D2C(var_0, var_1) {
  if(func_C229()) {
    var_1 = func_FCA8(var_1, self.config.var_C228 - 4);
  }

  var_2 = self.var_69F6;
  self.var_69F6 = undefined;
  var_3 = self.config.var_AC49 + var_1;
  playFXOnTag(level._effect["ims_sensor_explode"], self, var_3);
  func_9384(var_1, self.config);
  var_4 = self.config.var_39B;
  var_5 = self.triggerportableradarping;
  var_2 unlink();
  var_2 rotateyaw(3600, self.var_2528);
  var_2 moveto(self.var_2514 + self.origin, self.var_2528, self.var_2528 * 0.25, self.var_2528 * 0.25);
  if(isDefined(var_2.killcament)) {
    var_6 = var_2.killcament;
    var_6 unlink();
    if(isDefined(self.triggerportableradarping)) {
      self.triggerportableradarping.var_9381 = var_6;
    }

    var_6 moveto(self.var_2514 + self.origin + self.config.killcamoffset, self.var_2528, self.var_2528 * 0.25, self.var_2528 * 0.25);
    if(!func_C229()) {
      var_6 thread deleteaftertime(5);
    }
  }

  var_2 playSound("ims_launch");
  var_2 waittill("movedone");
  playFX(level._effect["ims_sensor_explode"], var_2.origin);
  var_7 = [];
  var_7[0] = var_0.origin;
  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    if(isDefined(var_5)) {
      scripts\mp\utility::_magicbullet(var_4, var_2.origin, var_7[var_8], var_5);
      continue;
    }

    scripts\mp\utility::_magicbullet(var_4, var_2.origin, var_7[var_8]);
  }

  var_2 delete();
  self notify("sensor_exploded");
}

deleteaftertime(var_0) {
  self endon("death");
  level scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  if(isDefined(self)) {
    self delete();
  }
}

func_937C() {
  self endon("death");
  level endon("game_ended");
  var_0 = level.var_9385[self.var_9386].lifespan;
  while(var_0) {
    wait(1);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    if(!isDefined(self.carriedby)) {
      var_0 = max(0, var_0 - 1);
    }
  }

  self notify("death");
}

func_184F() {
  var_0 = self getentitynumber();
  level.placedims[var_0] = self;
}

func_E10B() {
  var_0 = self getentitynumber();
  level.placedims[var_0] = undefined;
}

func_936A() {
  self hide();
  self.hidden = 1;
}

func_937A() {
  self show();
  self.hidden = 0;
  func_9383(self, 1);
}

func_937E(var_0) {
  var_1 = spawn("script_model", self gettagorigin(self.config.var_6A09 + var_0 + "_attach"));
  var_1 setModel(self.config.var_6A03);
  var_1.angles = self.angles;
  var_1.killcament = self.var_A637[var_0 - 1];
  var_1.killcament linkto(self);
  return var_1;
}

func_937F() {
  for(var_0 = 1; var_0 <= self.config.var_C228 && isDefined(self.var_8BF0[var_0]); var_0++) {}

  if(var_0 <= self.config.var_C228) {
    if(func_C229()) {
      var_0 = func_FCA8(var_0, self.config.var_C228 - 4);
    }

    var_1 = func_937E(var_0);
    var_1 linkto(self);
    self.var_69F6 = var_1;
  }
}

func_9384(var_0, var_1, var_2) {
  var_3 = var_1.var_AC49 + var_0 + "_attach";
  var_4 = undefined;
  if(isDefined(var_2)) {
    var_4 = var_1.var_AC48[var_0];
  } else {
    var_4 = var_1.var_AC47[var_0];
  }

  self scriptmodelplayanim(var_4);
  var_5 = var_1.var_6A09 + var_0 + "_attach";
  self hidepart(var_5);
}

func_9383(var_0, var_1) {
  var_2 = self.var_8BF0.size;
  if(var_2 > 0) {
    if(func_C229()) {
      var_2 = func_FCA8(var_2, self.config.var_C228 - 4);
    }

    var_0 func_9384(var_2, self.config, var_1);
  }
}

func_C229() {
  return self.config.var_C228 > 4;
}

func_FCA8(var_0, var_1) {
  var_2 = var_0 - var_1;
  var_2 = max(1, var_2);
  return int(var_2);
}