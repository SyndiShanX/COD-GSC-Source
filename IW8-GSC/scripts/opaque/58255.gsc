/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58255.gsc
***********************************************/

function playertimestamp() {
  playertimestart();
  playertospectate();
  game["dialog"]["plunder_extract_fail_fulton"] = "plunder_plunder_extract_fail_fulton";
  level._effect["vfx_fulton_explode"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_fulton_destr.vfx");
}

#using_animtree("");

function playertimestart() {
  level.scr_animtree["fulton"] = #animtree;
  level.scr_anim["fulton"]["fulton_open"] = $wm_skyhook_ground_open;
  level.scr_animname["fulton"]["fulton_open"] = "wm_skyhook_ground_open";
  level.scr_anim["fulton"]["fulton_open_idle"] = % wm_skyhook_ground_idle_open;
  level.scr_animname["fulton"]["fulton_open_idle"] = "wm_skyhook_ground_idle_open";
  level.scr_anim["fulton"]["fulton_takeoff"] = % wm_skyhook_ground_takeoff;
  level.scr_animname["fulton"]["fulton_takeoff"] = "wm_skyhook_ground_takeoff";
}

function playertospectate() {
  var0 = scripts\mp\gametypes\br_plunder::ref_1278c("equip_mp_fulton", 1);
  var0.type = 0;
  var0.usetime = getdvarfloat("scr_fultonUseTime", 0.75);
  var0.ref_14077 = 2;
  var0.ref_14075 = getdvarint("scr_fultonUseAmount", 250);
  var0.ref_13acc = 1;
  var0.ref_13aa5 = 1;
  var0.ref_14078 = "MP/CANNOT_DEPOSIT_CASH_BALLOON_FULL";
  var0.ref_14079 = "MP/CANNOT_DEPOSIT_CASH_BALLOON_LEAVING";
  var0.ref_12f7d = "fulton_use_cache";
  var0.ref_12f7e = "usable";
  var0.ref_12f77 = "unusable";
  var0.origin_delta = getdvarint("scr_fultonCountdown", 20);
  var0.original_disablelongdeath = "MP/CASH_BALLOON_LEAVING_IN_N";
  var0.get_closest_enemy_near_turret = getdvarint("scr_fultonCapacity", 1500);
  var0.impactwatcher = &playerupdatebesttimehud;
  var0.org_in_bad_place = &playerupdatehudstate;
  var0.carriable_error_messsage_watch = &playerupdatealivecounthuman;
  var0.outline_enemy_ai_for_duration = "fulton";
  var0.dropplunder = getdvarint("scr_fultonDropPlunder", 1) > 0;
  var0.get_chopper_boss_combat_action = getdvarint("scr_fultonCanTakeDamage", 1) > 0;
}

function playersusing(var0) {
  var1 = spawn("script_model", var0.origin);
  var1 getuseholdkbmprofile(1);
  var1 setModel("military_skyhook_far_mp_ch3");
  var1.angles = var0.angles;
  var1.owner = self;
  var1.team = self.team;

  if(isDefined(var0.moving_platform)) {
    var1.moving_platform = var0.moving_platform;
  }

  var1.animname = "fulton";
  var1 scripts\common\anim::setanimtree();
  self.playerstartpowers = var1;
  thread playerumpedfromplane();
}

function playerswithoutdismemberment(var0) {
  var1 = scripts\mp\gametypes\br_plunder::ref_1278c("equip_mp_fulton");
  thread scripts\mp\gametypes\br::ref_13ac7("br_fulton_balloon_shot_down", self.owner, self.team);
  scripts\mp\gametypes\br_plunder::num_rocket_per_attack(var1.dropplunder);
  playFX(scripts\engine\utility::getfx("vfx_fulton_explode"), self.origin, anglesToForward(self.angles));
  playsoundatpos(self.origin, "br_fulton_extract_exp");
  thread playerswapteam();
}

function playerswapteam() {
  self notify("death");

  if(isDefined(self.owner)) {
    self.owner.playerstartpowers = undefined;
  }

  self hide();
  scripts\mp\damage::monitordamageend();
  self setscriptablepartstate("fulton_use_cache", "unusable", 0);
  self setscriptablepartstate("fulton_use_extract", "unusable", 0);
  self setscriptablepartstate("effects", "neutral", 0);
  scripts\mp\gametypes\br_plunder::ref_12786(self);
  self stopanimScripted();

  if(isDefined(self.scenenode)) {
    self.scenenode delete();
  }

  waitframe();

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function playerwager(var0) {
  self endon("death_or_disconnect");
  jumpiftrue(istrue(level.br_plunder_enabled)) LOC_00000014;
  return;
}

function playerstreamhintlocation(var0, var1) {
  if(isDefined(var1.write_to_dlog_runtime_struct_data)) {
    if(isDefined(var1.write_to_dlog_runtime_struct_data.targetname)) {
      if(var1.write_to_dlog_runtime_struct_data.targetname == "train_wz") {
        var0.moving_platform = var1;
        return;
      }

      return;
    }

    return;
  }

  if(isDefined(var1.targetname) && var1.targetname == "train_wz") {
    var0.moving_platform = var1;
    return;
  }
}

function playerumpedfromplane() {
  self endon("death");
  self endon("start_extract");
  playsoundatpos(self.origin, "fulton_bag_drop");
  thread scripts\mp\gametypes\br::ref_13ac7("br_fulton_device_placed", self.owner, self.team);
  var0 = scripts\mp\utility\teams::getfriendlyplayers(self.team);
  scripts\mp\gametypes\br_plunder::ref_12796(self, "equip_mp_fulton");
  thread scripts\mp\gametypes\br_plunder::ref_127a4(self, var0);
  scripts\mp\gametypes\br_plunder::ref_127aa(self, var0);
  var1 = spawn("script_model", self.origin);
  var1 setModel("tag_origin");
  var1.angles = self.angles * (0, 1, 0);
  var1.playerstartpowers = self;
  self.scenenode = var1;

  if(isDefined(self.moving_platform)) {
    self linkTo(self.moving_platform);
    var1 linkTo(self.moving_platform);
  }

  playertracking();
  var2 = scripts\mp\gametypes\br_plunder::ref_1278c("equip_mp_fulton", 1);

  if(var2.get_chopper_boss_combat_action) {
    thread scripts\mp\damage::monitordamage(500, "", &playerteleporttoloc, &playerteleportprop);
    return;
  }
}

function playertracking() {
  self setscriptablepartstate("effects", "fillUp", 0);
  self.scenenode scripts\common\anim::anim_single_solo(self, "fulton_open");
  GscBinSkip4(0x35);
}

function playertryzombiespawn() {
  for(;;) {
    self.scenenode scripts\common\anim::anim_single_solo(self, "fulton_open_idle");
  }
}

function playerteleportprop(var0) {
  var1 = var0.damage;

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var0.attacker, self.owner))) {
    var1 = 0;
  } else {
    var1 = scripts\mp\damage::handleshotgundamage(var0.objweapon, var0.meansofdeath, var0.damage);
    var2 = undefined;

    if(var0.meansofdeath == "MOD_MELEE") {
      var1 = int(ceil(self.maxhealth / 6));
    } else if(isexplosivedamagemod(var0.meansofdeath)) {
      if(var0.damage >= 50) {
        var1 = int(ceil(self.maxhealth / 2));
      }
    }
  }

  return var1;
}

function playerteleporttoloc(var0) {
  thread playerswithoutdismemberment(var0);
}

function playerusehealslot(var0, var1, var2) {
  var3 = scripts\mp\gametypes\br_plunder::ref_1278c("equip_mp_fulton");
  var1 thread scripts\mp\gametypes\br_plunder::ref_1261f(var2, var3.ref_14077, var0);
}

function playerupdatebesttimehud(var0, var1) {
  if(isDefined(var0.owner)) {
    var0.owner.playerstartpowers = undefined;
  }

  scripts\mp\gametypes\br_plunder::ref_1279d(var0);
}

function playerupdatehudstate(var0) {
  var0 endon("death");
  var1 = scripts\mp\gametypes\br_plunder::ref_1278c("equip_mp_fulton");
  var2 = undefined;
  var0 scripts\mp\damage::monitordamageend();
  var2 = scripts\mp\gametypes\br_plunder::num_players_in_safehouse();
  thread scripts\mp\gametypes\br::ref_13ac7("br_fulton_balloon_successfully_away", self.owner, self.team);
  self notify("fulton_takeoff");
  self playsoundonmovingent("br_fulton_balloon_away");
  self.scenenode scripts\common\anim::anim_single_solo(self, "fulton_takeoff");
  thread playerswapteam();
}

function playerupdatealivecounthuman(var0) {
  thread scripts\mp\gametypes\br::ref_13ac7("br_fulton_balloon_full", var0.owner, var0.team);
}

function playerstreamhintdroptoground(var0) {
  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return true;
  }

  var1 = 25;
  var2 = scripts\cp_mp\parachute::getc130height();
  var3 = var0.origin + (0, 0, var1 + 1);
  var4 = (var0.origin[0], var0.origin[1], var2);
  var5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var6 = scripts\engine\trace::sphere_trace(var3, var4, var1, var0, var5);
  return var6["fraction"] == 1;
}

function playerunpackdatafromomnvar() {
  self setweaponammoclip(self.super.staticdata.weapon, 1);
  self notify("super_use_finished_lb");
  self notify("super_use_finished");
  scripts\cp\vehicles\vehicle_compass_cp::ref_12097(self.super, 1);
  var0 = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::ref_131c7(0);
  scripts\mp\supers::ref_131c6(0);
  var0.wasrefunded = 1;
  scripts\mp\supers::setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded());
}