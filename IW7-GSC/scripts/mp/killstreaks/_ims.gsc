/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_ims.gsc
*******************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("ims", ::func_128EA);
  level.var_9385 = [];
  var_00 = spawnStruct();
  var_00.var_39B = "ims_projectile_mp";
  var_00.modelbase = "ims_scorpion_body_iw6";
  var_00.modelplacement = "ims_scorpion_body_iw6_placement";
  var_00.modelplacementfailed = "ims_scorpion_body_iw6_placement_failed";
  var_00.modeldestroyed = "ims_scorpion_body_iw6";
  var_00.modelbombsquad = "ims_scorpion_body_iw6_bombsquad";
  var_00.pow = &"KILLSTREAKS_HINTS_IMS_PICKUP_TO_MOVE";
  var_00.placestring = &"KILLSTREAKS_HINTS_IMS_PLACE";
  var_00.cannotplacestring = &"KILLSTREAKS_HINTS_IMS_CANNOT_PLACE";
  var_00.streakname = "ims";
  var_00.var_10A38 = "used_ims";
  var_00.maxhealth = 670;
  var_00.lifespan = 90;
  var_00.var_DDAC = 0.5;
  var_00._meth_8487 = 0.4;
  var_00.var_C228 = 4;
  var_00.var_6A03 = "ims_scorpion_explosive_iw6";
  var_00.placementheighttolerance = 30;
  var_00.placementradius = 24;
  var_00.var_AC49 = "tag_lid";
  var_00.var_AC47 = [];
  var_00.var_AC47[1] = "IMS_Scorpion_door_1";
  var_00.var_AC47[2] = "IMS_Scorpion_door_2";
  var_00.var_AC47[3] = "IMS_Scorpion_door_3";
  var_00.var_AC47[4] = "IMS_Scorpion_door_4";
  var_00.var_AC48 = [];
  var_00.var_AC48[1] = "IMS_Scorpion_1_opened";
  var_00.var_AC48[2] = "IMS_Scorpion_2_opened";
  var_00.var_AC48[3] = "IMS_Scorpion_3_opened";
  var_00.var_6A09 = "tag_explosive";
  var_00.killcamoffset = (0, 0, 12);
  level.var_9385["ims"] = var_00;
  level._effect["ims_explode_mp"] = loadfx("vfx\iw7\_requests\mp\vfx_generic_equipment_exp_lg.vfx");
  level._effect["ims_smoke_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_damage_blacksmoke");
  level._effect["ims_sensor_explode"] = loadfx("vfx\core\mp\killstreaks\vfx_ims_sparks");
  level._effect["ims_antenna_light_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_light_detonator_blink");
  level.placedims = [];
}

func_128EA(param_00) {
  var_01 = [];
  if(isDefined(self.var_9382)) {
    var_01 = self.var_9382;
  }

  var_02 = setwaitspeed("ims", param_00);
  if(!isDefined(var_02)) {
    var_02 = 0;
    if(isDefined(self.var_9382)) {
      if(!var_01.size && self.var_9382.size) {
        var_02 = 1;
      }

      if(var_01.size && var_01[0] != self.var_9382[0]) {
        var_02 = 1;
      }
    }
  }

  if(var_02) {
    scripts\mp\matchdata::logkillstreakevent(param_00.streakname, self.origin);
  }

  self.iscarrying = 0;
  return var_02;
}

setwaitspeed(param_00, param_01) {
  var_02 = createimsforplayer(param_00, self);
  param_01.var_9380 = var_02;
  removeperks();
  self.carriedims = var_02;
  var_02.firstplacement = 1;
  var_03 = func_F684(var_02, 1);
  self.carriedims = undefined;
  thread restoreperks();
  return var_03;
}

func_F684(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  param_00 thread func_9377(self);
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
    var_02 = scripts\engine\utility::waittill_any_return("place_ims", "cancel_ims", "force_cancel_placement", "killstreak_trigger_blocked");
    if(var_02 == "cancel_ims" || var_02 == "force_cancel_placement" || var_02 == "killstreak_trigger_blocked") {
      if(!param_01 && var_02 == "cancel_ims" || var_02 == "killstreak_trigger_blocked") {
        continue;
      }

      param_00 ims_setcancelled(var_02 == "force_cancel_placement" && !isDefined(param_00.firstplacement));
      return 0;
    }

    if(!param_00.canbeplaced) {
      continue;
    }

    param_00 thread func_9379();
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

createimsforplayer(param_00, param_01) {
  if(isDefined(param_01.iscarrying) && param_01.iscarrying) {
    return;
  }

  var_02 = spawnturret("misc_turret", param_01.origin + (0, 0, 25), "sentry_minigun_mp");
  var_02.angles = param_01.angles;
  var_02.var_9386 = param_00;
  var_02.triggerportableradarping = param_01;
  var_02 setModel(level.var_9385[param_00].modelbase);
  var_02 getvalidattachments();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(param_01);
  return var_02;
}

createims(param_00) {
  var_01 = param_00.triggerportableradarping;
  var_02 = param_00.var_9386;
  var_03 = spawn("script_model", param_00.origin);
  var_03 setModel(level.var_9385[var_02].modelbase);
  var_03.var_EB9C = 3;
  var_03.angles = param_00.angles;
  var_03.var_9386 = var_02;
  var_03.triggerportableradarping = var_01;
  var_03 setotherent(var_01);
  var_03.team = var_01.team;
  var_03.shouldsplash = 0;
  var_03.hidden = 0;
  var_03.var_252E = 1;
  var_03 getqacalloutalias();
  var_03.var_8BF0 = [];
  var_03.config = level.var_9385[var_02];
  var_03 thread func_9369();
  var_03 thread func_937C();
  var_03 thread func_9363();
  var_03 thread func_9372();
  return var_03;
}

func_9363() {
  var_00 = spawn("script_model", self.origin);
  var_00.angles = self.angles;
  var_00 hide();
  var_00 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.triggerportableradarping);
  var_00 setModel(level.var_9385[self.var_9386].modelbombsquad);
  var_00 linkto(self);
  var_00 setcontents(0);
  self.bombsquadmodel = var_00;
  self waittill("death");
  if(isDefined(var_00)) {
    var_00 delete();
  }
}

func_936D(param_00) {
  self.var_933C = 1;
  self notify("death");
}

func_9366() {
  self endon("carried");
  scripts\mp\damage::monitordamage(self.config.maxhealth, "ims", ::func_9368, ::func_936C, 1);
}

func_936C(param_00, param_01, param_02, param_03, param_04) {
  if(self.hidden || param_01 == "ims_projectile_mp") {
    return -1;
  }

  var_05 = param_03;
  if(param_02 == "MOD_MELEE") {
    var_05 = self.maxhealth * 0.25;
  }

  if(isexplosivedamagemod(param_02)) {
    var_05 = param_03 * 1.5;
  }

  var_05 = scripts\mp\damage::handlemissiledamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  return var_05;
}

func_9368(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\damage::onkillstreakkilled("ims", param_00, param_01, param_02, param_03, "destroyed_ims", "ims_destroyed");
  if(var_04) {
    param_00 notify("destroyed_equipment");
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
    self waittill("emp_damage", var_00, var_01);
    scripts\mp\weapons::stopblinkinglight();
    playFX(scripts\engine\utility::getfx("emp_stun"), self.origin);
    playFX(scripts\engine\utility::getfx("ims_smoke_mp"), self.origin);
    wait(var_01);
    func_937B();
  }
}

func_9369() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_00);
    if(!scripts\mp\utility::isreallyalive(var_00)) {
      continue;
    }

    if(self.var_E1 >= self.maxhealth) {
      continue;
    }

    var_01 = createimsforplayer(self.var_9386, var_00);
    if(!isDefined(var_01)) {
      continue;
    }

    var_01.var_935F = self;
    func_9378();
    func_936A();
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_00 func_F684(var_01, 0);
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
  var_00 = undefined;
  if(isDefined(self.var_935F)) {
    var_00 = self.var_935F;
    var_00 endon("death");
    var_00.origin = self.origin;
    var_00.angles = self.angles;
    var_00.carriedby = undefined;
    var_00 func_937A();
    if(isDefined(var_00.bombsquadmodel)) {
      var_00.bombsquadmodel show();
      var_00 func_9383(var_00.bombsquadmodel, 1);
      level notify("update_bombsquad");
    }
  } else {
    var_00 = createims(self);
  }

  var_00 func_184F();
  var_00.isplaced = 1;
  var_00 thread func_9366();
  var_00 thread watchempdamage();
  var_00 thread func_9367();
  var_00 setCanDamage(1);
  self playSound("ims_plant");
  self notify("placed");
  var_00 thread func_9375();
  var_01 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_01.linkparent = self.moving_platform;
  }

  var_01.endonstring = "carried";
  var_01.deathoverridecallback = ::func_936D;
  var_00 thread scripts\mp\movers::handle_moving_platforms(var_01);
  self delete();
}

ims_setcancelled(param_00) {
  if(isDefined(self.carriedby)) {
    var_01 = self.carriedby;
    var_01 getrigindexfromarchetyperef();
    var_01.iscarrying = undefined;
    var_01.carrieditem = undefined;
    var_01 scripts\engine\utility::allow_weapon(1);
    if(isDefined(var_01.var_9382)) {
      foreach(var_03 in var_01.var_9382) {
        if(isDefined(var_03.bombsquadmodel)) {
          var_03.bombsquadmodel delete();
        }
      }
    }
  }

  if(isDefined(param_00) && param_00) {
    scripts\mp\weapons::equipmentdeletevfx();
  }

  self delete();
}

func_9377(param_00) {
  func_E10B();
  self setModel(level.var_9385[self.var_9386].modelplacement);
  self setsentrycarrier(param_00);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread func_12EB0(self);
  thread func_936E(param_00);
  thread func_936F(param_00);
  thread func_9371();
  thread func_9370(param_00);
  self notify("carried");
  if(isDefined(self.var_935F)) {
    self.var_935F notify("carried");
    self.var_935F.carriedby = param_00;
    self.var_935F.isplaced = 0;
    if(isDefined(self.var_935F.bombsquadmodel)) {
      self.var_935F.bombsquadmodel hide();
    }
  }
}

func_12EB0(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("placed");
  param_00 endon("death");
  param_00.canbeplaced = 1;
  var_01 = -1;
  var_02 = level.var_9385[param_00.var_9386];
  for(;;) {
    var_03 = self canplayerplacesentry(1, var_02.placementradius);
    param_00.origin = var_03["origin"];
    param_00.angles = var_03["angles"];
    param_00.canbeplaced = self isonground() && var_03["result"] && abs(param_00.origin[2] - self.origin[2]) < var_02.placementheighttolerance;
    if(isDefined(var_03["entity"])) {
      param_00.moving_platform = var_03["entity"];
    } else {
      param_00.moving_platform = undefined;
    }

    if(param_00.canbeplaced != var_01) {
      if(param_00.canbeplaced) {
        param_00 setModel(level.var_9385[param_00.var_9386].modelplacement);
        self forceusehinton(level.var_9385[param_00.var_9386].placestring);
      } else {
        param_00 setModel(level.var_9385[param_00.var_9386].modelplacementfailed);
        self forceusehinton(level.var_9385[param_00.var_9386].cannotplacestring);
      }
    }

    var_01 = param_00.canbeplaced;
    wait(0.05);
  }
}

func_936E(param_00) {
  self endon("placed");
  self endon("death");
  param_00 endon("disconnect");
  param_00 waittill("death");
  if(self.canbeplaced && param_00.team != "spectator") {
    thread func_9379();
    return;
  }

  ims_setcancelled();
}

func_936F(param_00) {
  self endon("placed");
  self endon("death");
  param_00 waittill("disconnect");
  ims_setcancelled();
}

func_9370(param_00) {
  self endon("placed");
  self endon("death");
  for(;;) {
    if(isDefined(self.carriedby.onhelisniper) && self.carriedby.onhelisniper) {
      self notify("death");
    }

    wait(0.1);
  }
}

func_9371(param_00) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  ims_setcancelled();
}

func_9375() {
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.var_9385[self.var_9386].pow);
  var_00 = self.triggerportableradarping;
  var_00 getrigindexfromarchetyperef();
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 60));
  } else {
    scripts\mp\entityheadicons::setplayerheadicon(var_00, (0, 0, 60));
  }

  self makeusable();
  self setCanDamage(1);
  if(isDefined(var_00.var_9382)) {
    foreach(var_02 in var_00.var_9382) {
      if(var_02 == self) {
        continue;
      }

      var_02 notify("death");
    }
  }

  var_00.var_9382 = [];
  var_00.var_9382[0] = self;
  foreach(var_05 in level.players) {
    if(var_05 == var_00) {
      self enableplayeruse(var_05);
      continue;
    }

    self disableplayeruse(var_05);
  }

  if(self.shouldsplash) {
    level thread scripts\mp\utility::teamplayercardsplash(level.var_9385[self.var_9386].var_10A38, var_00);
    self.shouldsplash = 0;
  }

  var_07 = (0, 0, 20);
  var_08 = (0, 0, 256) - var_07;
  var_09 = [];
  self.var_A637 = [];
  for(var_0A = 0; var_0A < self.config.var_C228; var_0A++) {
    if(func_C229()) {
      var_0B = func_FCA8(var_0A + 1, self.config.var_C228 - 4);
    } else {
      var_0B = var_0A + 1;
    }

    var_0C = self gettagorigin(self.config.var_6A09 + var_0B + "_attach");
    var_0D = self gettagorigin(self.config.var_6A09 + var_0B + "_attach") + var_07;
    var_09[var_0A] = bulletTrace(var_0D, var_0D + var_08, 0, self);
    if(var_0A < 4) {
      var_0E = spawn("script_model", var_0C + self.config.killcamoffset);
      var_0E setscriptmoverkillcam("explosive");
      self.var_A637[self.var_A637.size] = var_0E;
    }
  }

  var_0F = var_09[0];
  for(var_0A = 0; var_0A < var_09.size; var_0A++) {
    if(var_09[var_0A]["position"][2] < var_0F["position"][2]) {
      var_0F = var_09[var_0A];
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
  foreach(var_05 in level.players) {
    thread func_9374(var_05);
  }
}

func_937D() {
  self endon("death");
  for(;;) {
    level waittill("connected", var_00);
    func_9373(var_00);
  }
}

func_9373(param_00) {
  self endon("death");
  param_00 endon("disconnect");
  param_00 waittill("spawned_player");
  self disableplayeruse(param_00);
}

func_9374(param_00) {
  self endon("death");
  param_00 endon("disconnect");
  for(;;) {
    param_00 waittill("joined_team");
    self disableplayeruse(param_00);
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
    foreach(var_01 in self.var_A637) {
      if(isDefined(var_01)) {
        if(isDefined(self.triggerportableradarping) && isDefined(self.triggerportableradarping.var_9381) && var_01 == self.triggerportableradarping.var_9381) {
          continue;
        } else {
          var_01 delete();
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

isfriendlytoims(param_00) {
  if(level.teambased && self.team == param_00.team) {
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

    self.var_2536 waittill("trigger", var_00);
    if(isplayer(var_00)) {
      if(isDefined(self.triggerportableradarping) && var_00 == self.triggerportableradarping) {
        continue;
      }

      if(level.teambased && var_00.pers["team"] == self.team) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_00)) {
        continue;
      }
    } else if(isDefined(var_00.triggerportableradarping)) {
      if(isDefined(self.triggerportableradarping) && var_00.triggerportableradarping == self.triggerportableradarping) {
        continue;
      }

      if(level.teambased && var_00.triggerportableradarping.pers["team"] == self.team) {
        continue;
      }
    }

    var_01 = var_00.origin + (0, 0, 50);
    if(!sighttracepassed(self.var_2514 + self.origin, var_01, 0, self)) {
      continue;
    }

    var_02 = 0;
    for(var_03 = 1; var_03 <= self.config.var_C228; var_03++) {
      if(var_03 > 4) {
        break;
      }

      if(sighttracepassed(self gettagorigin(self.config.var_AC49 + var_03), var_01, 0, self)) {
        var_02 = 1;
        break;
      }
    }

    if(!var_02) {
      continue;
    }

    self playSound("ims_trigger");
    scripts\mp\weapons::explosivetrigger(var_00, level.var_9385[self.var_9386]._meth_8487, "ims");
    if(!isDefined(self.var_2536)) {
      break;
    }

    if(!isDefined(self.var_8BF0[self.var_252E])) {
      self.var_8BF0[self.var_252E] = 1;
      thread func_6D2C(var_00, self.var_252E);
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

func_6D2C(param_00, param_01) {
  if(func_C229()) {
    param_01 = func_FCA8(param_01, self.config.var_C228 - 4);
  }

  var_02 = self.var_69F6;
  self.var_69F6 = undefined;
  var_03 = self.config.var_AC49 + param_01;
  playFXOnTag(level._effect["ims_sensor_explode"], self, var_03);
  func_9384(param_01, self.config);
  var_04 = self.config.var_39B;
  var_05 = self.triggerportableradarping;
  var_02 unlink();
  var_02 rotateyaw(3600, self.var_2528);
  var_02 moveto(self.var_2514 + self.origin, self.var_2528, self.var_2528 * 0.25, self.var_2528 * 0.25);
  if(isDefined(var_02.killcament)) {
    var_06 = var_02.killcament;
    var_06 unlink();
    if(isDefined(self.triggerportableradarping)) {
      self.triggerportableradarping.var_9381 = var_06;
    }

    var_06 moveto(self.var_2514 + self.origin + self.config.killcamoffset, self.var_2528, self.var_2528 * 0.25, self.var_2528 * 0.25);
    if(!func_C229()) {
      var_06 thread deleteaftertime(5);
    }
  }

  var_02 playSound("ims_launch");
  var_02 waittill("movedone");
  playFX(level._effect["ims_sensor_explode"], var_02.origin);
  var_07 = [];
  var_07[0] = param_00.origin;
  for(var_08 = 0; var_08 < var_07.size; var_08++) {
    if(isDefined(var_05)) {
      scripts\mp\utility::_magicbullet(var_04, var_02.origin, var_07[var_08], var_05);
      continue;
    }

    scripts\mp\utility::_magicbullet(var_04, var_02.origin, var_07[var_08]);
  }

  var_02 delete();
  self notify("sensor_exploded");
}

deleteaftertime(param_00) {
  self endon("death");
  level scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  if(isDefined(self)) {
    self delete();
  }
}

func_937C() {
  self endon("death");
  level endon("game_ended");
  var_00 = level.var_9385[self.var_9386].lifespan;
  while(var_00) {
    wait(1);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    if(!isDefined(self.carriedby)) {
      var_00 = max(0, var_00 - 1);
    }
  }

  self notify("death");
}

func_184F() {
  var_00 = self getentitynumber();
  level.placedims[var_00] = self;
}

func_E10B() {
  var_00 = self getentitynumber();
  level.placedims[var_00] = undefined;
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

func_937E(param_00) {
  var_01 = spawn("script_model", self gettagorigin(self.config.var_6A09 + param_00 + "_attach"));
  var_01 setModel(self.config.var_6A03);
  var_01.angles = self.angles;
  var_01.killcament = self.var_A637[param_00 - 1];
  var_01.killcament linkto(self);
  return var_01;
}

func_937F() {
  for(var_00 = 1; var_00 <= self.config.var_C228 && isDefined(self.var_8BF0[var_00]); var_00++) {}

  if(var_00 <= self.config.var_C228) {
    if(func_C229()) {
      var_00 = func_FCA8(var_00, self.config.var_C228 - 4);
    }

    var_01 = func_937E(var_00);
    var_01 linkto(self);
    self.var_69F6 = var_01;
  }
}

func_9384(param_00, param_01, param_02) {
  var_03 = param_01.var_AC49 + param_00 + "_attach";
  var_04 = undefined;
  if(isDefined(param_02)) {
    var_04 = param_01.var_AC48[param_00];
  } else {
    var_04 = param_01.var_AC47[param_00];
  }

  self scriptmodelplayanim(var_04);
  var_05 = param_01.var_6A09 + param_00 + "_attach";
  self hidepart(var_05);
}

func_9383(param_00, param_01) {
  var_02 = self.var_8BF0.size;
  if(var_02 > 0) {
    if(func_C229()) {
      var_02 = func_FCA8(var_02, self.config.var_C228 - 4);
    }

    param_00 func_9384(var_02, self.config, param_01);
  }
}

func_C229() {
  return self.config.var_C228 > 4;
}

func_FCA8(param_00, param_01) {
  var_02 = param_00 - param_01;
  var_02 = max(1, var_02);
  return int(var_02);
}