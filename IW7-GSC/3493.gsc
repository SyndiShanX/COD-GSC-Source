/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3493.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("ims", ::func_128EA);
  level.func_9385 = [];
  var_00 = spawnStruct();
  var_0.weaponinfo = "ims_projectile_mp";
  var_0.modelbase = "ims_scorpion_body_iw6";
  var_0.modelplacement = "ims_scorpion_body_iw6_placement";
  var_0.modelplacementfailed = "ims_scorpion_body_iw6_placement_failed";
  var_0.modeldestroyed = "ims_scorpion_body_iw6";
  var_0.modelbombsquad = "ims_scorpion_body_iw6_bombsquad";
  var_0.hintstring = &"KILLSTREAKS_HINTS_IMS_PICKUP_TO_MOVE";
  var_0.placestring = &"KILLSTREAKS_HINTS_IMS_PLACE";
  var_0.cannotplacestring = &"KILLSTREAKS_HINTS_IMS_CANNOT_PLACE";
  var_0.streakname = "ims";
  var_0.func_10A38 = "used_ims";
  var_0.maxhealth = 670;
  var_0.lifespan = 90.0;
  var_0.func_DDAC = 0.5;
  var_0._meth_8487 = 0.4;
  var_0.func_C228 = 4;
  var_0.func_6A03 = "ims_scorpion_explosive_iw6";
  var_0.placementheighttolerance = 30.0;
  var_0.placementradius = 24.0;
  var_0.func_AC49 = "tag_lid";
  var_0.func_AC47 = [];
  var_0.func_AC47[1] = "IMS_Scorpion_door_1";
  var_0.func_AC47[2] = "IMS_Scorpion_door_2";
  var_0.func_AC47[3] = "IMS_Scorpion_door_3";
  var_0.func_AC47[4] = "IMS_Scorpion_door_4";
  var_0.func_AC48 = [];
  var_0.func_AC48[1] = "IMS_Scorpion_1_opened";
  var_0.func_AC48[2] = "IMS_Scorpion_2_opened";
  var_0.func_AC48[3] = "IMS_Scorpion_3_opened";
  var_0.func_6A09 = "tag_explosive";
  var_0.killcamoffset = (0, 0, 12);
  level.func_9385["ims"] = var_00;
  level._effect["ims_explode_mp"] = loadfx("vfx\iw7\_requests\mp\vfx_generic_equipment_exp_lg.vfx");
  level._effect["ims_smoke_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_damage_blacksmoke");
  level._effect["ims_sensor_explode"] = loadfx("vfx\core\mp\killstreaks\vfx_ims_sparks");
  level._effect["ims_antenna_light_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_light_detonator_blink");
  level.placedims = [];
}

func_128EA(var_00) {
  var_01 = [];

  if(isDefined(self.func_9382))
    var_01 = self.func_9382;

  var_02 = setwaitspeed("ims", var_00);

  if(!isDefined(var_02)) {
    var_02 = 0;

    if(isDefined(self.func_9382)) {
      if(!var_1.size && self.func_9382.size)
        var_02 = 1;

      if(var_1.size && var_1[0] != self.func_9382[0])
        var_02 = 1;
    }
  }

  if(var_02)
    scripts\mp\matchdata::logkillstreakevent(var_0.streakname, self.origin);

  self.iscarrying = 0;
  return var_02;
}

setwaitspeed(var_00, var_01) {
  var_02 = createimsforplayer(var_00, self);
  var_1.func_9380 = var_02;
  removeperks();
  self.carriedims = var_02;
  var_2.firstplacement = 1;
  var_03 = func_F684(var_02, 1);
  self.carriedims = undefined;
  thread restoreperks();
  return var_03;
}

func_F684(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  var_00 thread func_9377(self);
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
      if(!var_01 && (var_02 == "cancel_ims" || var_02 == "killstreak_trigger_blocked")) {
        continue;
      }
      var_00 ims_setcancelled(var_02 == "force_cancel_placement" && !isDefined(var_0.firstplacement));
      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    var_00 thread func_9379();
    self notify("IMS_placed");
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    scripts\mp\utility\game::_takeweapon("iw6_riotshield_mp");
  }
}

removeperks() {
  if(scripts\mp\utility\game::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility\game::removeperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\mp\utility\game::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility\game::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  restoreperks();
}

createimsforplayer(var_00, var_01) {
  if(isDefined(var_1.iscarrying) && var_1.iscarrying) {
    return;
  }
  var_02 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_1.angles;
  var_2.func_9386 = var_00;
  var_2.owner = var_01;
  var_02 setModel(level.func_9385[var_00].modelbase);
  var_02 maketurretinoperable();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(var_01);
  return var_02;
}

createims(var_00) {
  var_01 = var_0.owner;
  var_02 = var_0.func_9386;
  var_03 = spawn("script_model", var_0.origin);
  var_03 setModel(level.func_9385[var_02].modelbase);
  var_3.func_EB9C = 3;
  var_3.angles = var_0.angles;
  var_3.func_9386 = var_02;
  var_3.owner = var_01;
  var_03 setotherent(var_01);
  var_3.team = var_1.team;
  var_3.shouldsplash = 0;
  var_3.hidden = 0;
  var_3.func_252E = 1;
  var_03 getqacalloutalias();
  var_3.func_8BF0 = [];
  var_3.config = level.func_9385[var_02];
  var_03 thread func_9369();
  var_03 thread func_937C();
  var_03 thread func_9363();
  var_03 thread func_9372();
  return var_03;
}

func_9363() {
  var_00 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_00 hide();
  var_00 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.owner);
  var_00 setModel(level.func_9385[self.func_9386].modelbombsquad);
  var_00 linkto(self);
  var_00 setcontents(0);
  self.bombsquadmodel = var_00;
  self waittill("death");

  if(isDefined(var_00))
    var_00 delete();
}

func_936D(var_00) {
  self.func_933C = 1;
  self notify("death");
}

func_9366() {
  self endon("carried");
  scripts\mp\damage::monitordamage(self.config.maxhealth, "ims", ::func_9368, ::func_936C, 1);
}

func_936C(var_00, var_01, var_02, var_03, var_04) {
  if(self.hidden || var_01 == "ims_projectile_mp")
    return -1;

  var_05 = var_03;

  if(var_02 == "MOD_MELEE")
    var_05 = self.maxhealth * 0.25;

  if(isexplosivedamagemod(var_02))
    var_05 = var_03 * 1.5;

  var_05 = scripts\mp\damage::handlemissiledamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(var_01, var_02, var_05);
  return var_05;
}

func_9368(var_00, var_01, var_02, var_03) {
  var_04 = scripts\mp\damage::onkillstreakkilled("ims", var_00, var_01, var_02, var_03, "destroyed_ims", "ims_destroyed");

  if(var_04)
    var_00 notify("destroyed_equipment");
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
    wait 1.0;
  } else if(isDefined(self.func_933C)) {
    playFX(scripts\engine\utility::getfx("ims_explode_mp"), self.origin + (0, 0, 10));
    self notify("deleting");
  } else {
    playFX(scripts\engine\utility::getfx("ims_explode_mp"), self.origin + (0, 0, 10));
    playFX(scripts\engine\utility::getfx("ims_smoke_mp"), self.origin);
    wait 3.0;
    self playSound("ims_fire");
    self notify("deleting");
  }

  if(isDefined(self.objidfriendly))
    scripts\mp\objidpoolmanager::returnminimapid(self.objidfriendly);

  if(isDefined(self.func_C2BA))
    scripts\mp\objidpoolmanager::returnminimapid(self.func_C2BA);

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

    if(!scripts\mp\utility\game::isreallyalive(var_00)) {
      continue;
    }
    if(self.damagetaken >= self.maxhealth) {
      continue;
    }
    var_01 = createimsforplayer(self.func_9386, var_00);

    if(!isDefined(var_01)) {
      continue;
    }
    var_1.func_935F = self;
    func_9378();
    func_936A();

    if(isDefined(self getlinkedparent()))
      self unlink();

    var_00 func_F684(var_01, 0);
  }
}

func_9379() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.carriedby))
    self.carriedby getrigindexfromarchetyperef();

  self.carriedby = undefined;

  if(isDefined(self.owner))
    self.owner.iscarrying = 0;

  self.firstplacement = undefined;
  var_00 = undefined;

  if(isDefined(self.func_935F)) {
    var_00 = self.func_935F;
    var_00 endon("death");
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0.carriedby = undefined;
    var_00 func_937A();

    if(isDefined(var_0.bombsquadmodel)) {
      var_0.bombsquadmodel show();
      var_00 func_9383(var_0.bombsquadmodel, 1);
      level notify("update_bombsquad");
    }
  } else
    var_00 = createims(self);

  var_00 func_184F();
  var_0.isplaced = 1;
  var_00 thread func_9366();
  var_00 thread watchempdamage();
  var_00 thread func_9367();
  var_00 setCanDamage(1);
  self playSound("ims_plant");
  self notify("placed");
  var_00 thread func_9375();
  var_01 = spawnStruct();

  if(isDefined(self.moving_platform))
    var_1.linkparent = self.moving_platform;

  var_1.endonstring = "carried";
  var_1.deathoverridecallback = ::func_936D;
  var_00 thread scripts\mp\movers::handle_moving_platforms(var_01);
  self delete();
}

ims_setcancelled(var_00) {
  if(isDefined(self.carriedby)) {
    var_01 = self.carriedby;
    var_01 getrigindexfromarchetyperef();
    var_1.iscarrying = undefined;
    var_1.carrieditem = undefined;
    var_01 scripts\engine\utility::allow_weapon(1);

    if(isDefined(var_1.func_9382)) {
      foreach(var_03 in var_1.func_9382) {
        if(isDefined(var_3.bombsquadmodel))
          var_3.bombsquadmodel delete();
      }
    }
  }

  if(isDefined(var_00) && var_00)
    scripts\mp\weapons::equipmentdeletevfx();

  self delete();
}

func_9377(var_00) {
  func_E10B();
  self setModel(level.func_9385[self.func_9386].modelplacement);
  self setsentrycarrier(var_00);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = var_00;
  var_0.iscarrying = 1;
  var_00 thread func_12EB0(self);
  thread func_936E(var_00);
  thread func_936F(var_00);
  thread func_9371();
  thread func_9370(var_00);
  self notify("carried");

  if(isDefined(self.func_935F)) {
    self.func_935F notify("carried");
    self.func_935F.carriedby = var_00;
    self.func_935F.isplaced = 0;

    if(isDefined(self.func_935F.bombsquadmodel))
      self.func_935F.bombsquadmodel hide();
  }
}

func_12EB0(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("placed");
  var_00 endon("death");
  var_0.canbeplaced = 1;
  var_01 = -1;
  var_02 = level.func_9385[var_0.func_9386];

  for(;;) {
    var_03 = self canplayerplacesentry(1, var_2.placementradius);
    var_0.origin = var_3["origin"];
    var_0.angles = var_3["angles"];
    var_0.canbeplaced = self isonground() && var_3["result"] && abs(var_0.origin[2] - self.origin[2]) < var_2.placementheighttolerance;

    if(isDefined(var_3["entity"]))
      var_0.moving_platform = var_3["entity"];
    else
      var_0.moving_platform = undefined;

    if(var_0.canbeplaced != var_01) {
      if(var_0.canbeplaced) {
        var_00 setModel(level.func_9385[var_0.func_9386].modelplacement);
        self forceusehinton(level.func_9385[var_0.func_9386].placestring);
      } else {
        var_00 setModel(level.func_9385[var_0.func_9386].modelplacementfailed);
        self forceusehinton(level.func_9385[var_0.func_9386].cannotplacestring);
      }
    }

    var_01 = var_0.canbeplaced;
    wait 0.05;
  }
}

func_936E(var_00) {
  self endon("placed");
  self endon("death");
  var_00 endon("disconnect");
  var_00 waittill("death");

  if(self.canbeplaced && var_0.team != "spectator")
    thread func_9379();
  else
    ims_setcancelled();
}

func_936F(var_00) {
  self endon("placed");
  self endon("death");
  var_00 waittill("disconnect");
  ims_setcancelled();
}

func_9370(var_00) {
  self endon("placed");
  self endon("death");

  for(;;) {
    if(isDefined(self.carriedby.onhelisniper) && self.carriedby.onhelisniper)
      self notify("death");

    wait 0.1;
  }
}

func_9371(var_00) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  ims_setcancelled();
}

func_9375() {
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.func_9385[self.func_9386].hintstring);
  var_00 = self.owner;
  var_00 getrigindexfromarchetyperef();

  if(level.teambased)
    scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 60));
  else
    scripts\mp\entityheadicons::setplayerheadicon(var_00, (0, 0, 60));

  self makeusable();
  self setCanDamage(1);

  if(isDefined(var_0.func_9382)) {
    foreach(var_02 in var_0.func_9382) {
      if(var_02 == self) {
        continue;
      }
      var_02 notify("death");
    }
  }

  var_0.func_9382 = [];
  var_0.func_9382[0] = self;

  foreach(var_05 in level.players) {
    if(var_05 == var_00) {
      self enableplayeruse(var_05);
      continue;
    }

    self disableplayeruse(var_05);
  }

  if(self.shouldsplash) {
    level thread scripts\mp\utility\game::teamplayercardsplash(level.func_9385[self.func_9386].func_10A38, var_00);
    self.shouldsplash = 0;
  }

  var_07 = (0, 0, 20);
  var_08 = (0, 0, 256) - var_07;
  var_09 = [];
  self.func_A637 = [];

  for(var_10 = 0; var_10 < self.config.func_C228; var_10++) {
    if(func_C229())
      var_11 = func_FCA8(var_10 + 1, self.config.func_C228 - 4);
    else
      var_11 = var_10 + 1;

    var_12 = self gettagorigin(self.config.func_6A09 + var_11 + "_attach");
    var_13 = self gettagorigin(self.config.func_6A09 + var_11 + "_attach") + var_07;
    var_9[var_10] = bulletTrace(var_13, var_13 + var_08, 0, self);

    if(var_10 < 4) {
      var_14 = spawn("script_model", var_12 + self.config.killcamoffset);
      var_14 setscriptmoverkillcam("explosive");
      self.func_A637[self.func_A637.size] = var_14;
    }
  }

  var_15 = var_9[0];

  for(var_10 = 0; var_10 < var_9.size; var_10++) {
    if(var_9[var_10]["position"][2] < var_15["position"][2])
      var_15 = var_9[var_10];
  }

  self.func_2514 = var_15["position"] - (0, 0, 20) - self.origin;
  var_16 = spawn("trigger_radius", self.origin, 0, 256, 100);
  self.func_2536 = var_16;
  self.func_2536 getrankxp();
  self.func_2536 linkto(self);
  self.func_2528 = length(self.func_2514) / 200;
  func_937F();
  func_937B();
  thread func_937D();

  foreach(var_05 in level.players)
  thread func_9374(var_05);
}

func_937D() {
  self endon("death");

  for(;;) {
    level waittill("connected", var_00);
    func_9373(var_00);
  }
}

func_9373(var_00) {
  self endon("death");
  var_00 endon("disconnect");
  var_00 waittill("spawned_player");
  self disableplayeruse(var_00);
}

func_9374(var_00) {
  self endon("death");
  var_00 endon("disconnect");

  for(;;) {
    var_00 waittill("joined_team");
    self disableplayeruse(var_00);
  }
}

func_9372() {
  self endon("death");
  level endon("game_ended");
  self.owner waittill("killstreak_disowned");

  if(isDefined(self.isplaced))
    self notify("death");
  else
    ims_setcancelled(0);
}

func_937B() {
  thread scripts\mp\weapons::doblinkinglight("tag_fx");
  thread func_9362();
}

func_9378() {
  self makeunusable();

  if(level.teambased)
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
  else if(isDefined(self.owner))
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));

  if(isDefined(self.func_2536))
    self.func_2536 delete();

  if(isDefined(self.func_A637)) {
    foreach(var_01 in self.func_A637) {
      if(isDefined(var_01)) {
        if(isDefined(self.owner) && isDefined(self.owner.func_9381) && var_01 == self.owner.func_9381)
          continue;
        else
          var_01 delete();
      }
    }
  }

  if(isDefined(self.func_69F6)) {
    self.func_69F6 delete();
    self.func_69F6 = undefined;
  }

  scripts\mp\weapons::stopblinkinglight();
}

isfriendlytoims(var_00) {
  if(level.teambased && self.team == var_0.team)
    return 1;

  return 0;
}

func_9362() {
  self endon("death");
  self endon("emp_damage");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.func_2536)) {
      break;
    }
    self.func_2536 waittill("trigger", var_00);

    if(isplayer(var_00)) {
      if(isDefined(self.owner) && var_00 == self.owner) {
        continue;
      }
      if(level.teambased && var_0.pers["team"] == self.team) {
        continue;
      }
      if(!scripts\mp\utility\game::isreallyalive(var_00))
        continue;
    } else if(isDefined(var_0.owner)) {
      if(isDefined(self.owner) && var_0.owner == self.owner) {
        continue;
      }
      if(level.teambased && var_0.owner.pers["team"] == self.team)
        continue;
    }

    var_01 = var_0.origin + (0, 0, 50);

    if(!sighttracepassed(self.func_2514 + self.origin, var_01, 0, self)) {
      continue;
    }
    var_02 = 0;

    for(var_03 = 1; var_03 <= self.config.func_C228; var_3++) {
      if(var_03 > 4) {
        break;
      }
      if(sighttracepassed(self gettagorigin(self.config.func_AC49 + var_03), var_01, 0, self)) {
        var_02 = 1;
        break;
      }
    }

    if(!var_02) {
      continue;
    }
    self playSound("ims_trigger");
    scripts\mp\weapons::explosivetrigger(var_00, level.func_9385[self.func_9386]._meth_8487, "ims");

    if(!isDefined(self.func_2536)) {
      break;
    }
    if(!isDefined(self.func_8BF0[self.func_252E])) {
      self.func_8BF0[self.func_252E] = 1;
      thread func_6D2C(var_00, self.func_252E);
      self.func_252E++;
    }

    if(self.func_252E > self.config.func_C228) {
      break;
    }
    func_937F();
    self waittill("sensor_exploded");
    wait(self.config.func_DDAC);

    if(!isDefined(self.owner)) {
      break;
    }
  }

  if(isDefined(self.carriedby) && isDefined(self.owner) && self.carriedby == self.owner) {
    return;
  }
  self notify("death");
}

func_6D2C(var_00, var_01) {
  if(func_C229())
    var_01 = func_FCA8(var_01, self.config.func_C228 - 4);

  var_02 = self.func_69F6;
  self.func_69F6 = undefined;
  var_03 = self.config.func_AC49 + var_01;
  playFXOnTag(level._effect["ims_sensor_explode"], self, var_03);
  func_9384(var_01, self.config);
  var_04 = self.config.weaponinfo;
  var_05 = self.owner;
  var_02 unlink();
  var_02 rotateyaw(3600, self.func_2528);
  var_02 moveto(self.func_2514 + self.origin, self.func_2528, self.func_2528 * 0.25, self.func_2528 * 0.25);

  if(isDefined(var_2.killcament)) {
    var_06 = var_2.killcament;
    var_06 unlink();

    if(isDefined(self.owner))
      self.owner.func_9381 = var_06;

    var_06 moveto(self.func_2514 + self.origin + self.config.killcamoffset, self.func_2528, self.func_2528 * 0.25, self.func_2528 * 0.25);

    if(!func_C229())
      var_06 thread deleteaftertime(5.0);
  }

  var_02 playSound("ims_launch");
  var_02 waittill("movedone");
  playFX(level._effect["ims_sensor_explode"], var_2.origin);
  var_07 = [];
  var_7[0] = var_0.origin;

  for(var_08 = 0; var_08 < var_7.size; var_8++) {
    if(isDefined(var_05)) {
      scripts\mp\utility\game::_magicbullet(var_04, var_2.origin, var_7[var_08], var_05);
      continue;
    }

    scripts\mp\utility\game::_magicbullet(var_04, var_2.origin, var_7[var_08]);
  }

  var_02 delete();
  self notify("sensor_exploded");
}

deleteaftertime(var_00) {
  self endon("death");
  level scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);

  if(isDefined(self))
    self delete();
}

func_937C() {
  self endon("death");
  level endon("game_ended");
  var_00 = level.func_9385[self.func_9386].lifespan;

  while(var_00) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby))
      var_00 = max(0, var_00 - 1.0);
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

func_937E(var_00) {
  var_01 = spawn("script_model", self gettagorigin(self.config.func_6A09 + var_00 + "_attach"));
  var_01 setModel(self.config.func_6A03);
  var_1.angles = self.angles;
  var_1.killcament = self.func_A637[var_00 - 1];
  var_1.killcament linkto(self);
  return var_01;
}

func_937F() {
  for(var_00 = 1; var_00 <= self.config.func_C228 && isDefined(self.func_8BF0[var_00]); var_0++) {}

  if(var_00 <= self.config.func_C228) {
    if(func_C229())
      var_00 = func_FCA8(var_00, self.config.func_C228 - 4);

    var_01 = func_937E(var_00);
    var_01 linkto(self);
    self.func_69F6 = var_01;
  }
}

func_9384(var_00, var_01, var_02) {
  var_03 = var_1.func_AC49 + var_00 + "_attach";
  var_04 = undefined;

  if(isDefined(var_02))
    var_04 = var_1.func_AC48[var_00];
  else
    var_04 = var_1.func_AC47[var_00];

  self scriptmodelplayanim(var_04);
  var_05 = var_1.func_6A09 + var_00 + "_attach";
  self hidepart(var_05);
}

func_9383(var_00, var_01) {
  var_02 = self.func_8BF0.size;

  if(var_02 > 0) {
    if(func_C229())
      var_02 = func_FCA8(var_02, self.config.func_C228 - 4);

    var_00 func_9384(var_02, self.config, var_01);
  }
}

func_C229() {
  return self.config.func_C228 > 4;
}

func_FCA8(var_00, var_01) {
  var_02 = var_00 - var_01;
  var_02 = max(1, var_02);
  return int(var_02);
}