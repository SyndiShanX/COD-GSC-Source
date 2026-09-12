/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58255.gsc
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
  var_0 = scripts\mp\gametypes\br_plunder::ref_1278c("equip_mp_fulton", 1);
  var_0.type = 0;
  var_0.usetime = getdvarfloat("scr_fultonUseTime", 0.75);
  var_0.ref_14077 = 2;
  var_0.ref_14075 = getdvarint("scr_fultonUseAmount", 250);
  var_0.ref_13acc = 1;
  var_0.ref_13aa5 = 1;
  var_0.ref_14078 = "MP/CANNOT_DEPOSIT_CASH_BALLOON_FULL";
  var_0.ref_14079 = "MP/CANNOT_DEPOSIT_CASH_BALLOON_LEAVING";
  var_0.ref_12f7d = "fulton_use_cache";
  var_0.ref_12f7e = "usable";
  var_0.ref_12f77 = "unusable";
  var_0.origin_delta = getdvarint("scr_fultonCountdown", 20);
  var_0.original_disablelongdeath = "MP/CASH_BALLOON_LEAVING_IN_N";
  var_0.get_closest_enemy_near_turret = getdvarint("scr_fultonCapacity", 1500);
  var_0.impactwatcher = &playerupdatebesttimehud;
  var_0.org_in_bad_place = &playerupdatehudstate;
  var_0.carriable_error_messsage_watch = &playerupdatealivecounthuman;
  var_0.outline_enemy_ai_for_duration = "fulton";
  var_0.dropplunder = getdvarint("scr_fultonDropPlunder", 1) > 0;
  var_0.get_chopper_boss_combat_action = getdvarint("scr_fultonCanTakeDamage", 1) > 0;
}

function playersusing(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 getuseholdkbmprofile(1);
  var_1 setModel("military_skyhook_far_mp_ch3");
  var_1.angles = var_0.angles;
  var_1.owner = self;
  var_1.team = self.team;

  if(isDefined(var_0.moving_platform)) {
    var_1.moving_platform = var_0.moving_platform;
  }

  var_1.animname = "fulton";
  var_1 scripts\common\anim::setanimtree();
  self.playerstartpowers = var_1;
  thread playerumpedfromplane();
}

function playerswithoutdismemberment(var_0) {
  var_1 = scripts\mp\gametypes\br_plunder::ref_1278c("equip_mp_fulton");
  thread scripts\mp\gametypes\br::ref_13ac7("br_fulton_balloon_shot_down", self.owner, self.team);
  scripts\mp\gametypes\br_plunder::num_rocket_per_attack(var_1.dropplunder);
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

function playerwager(var_0) {
  self endon("death_or_disconnect");
  jumpiftrue(istrue(level.br_plunder_enabled)) LOC_00000014;
  return;
}

function playerstreamhintlocation(var_0, var_1) {
  if(isDefined(var_1.write_to_dlog_runtime_struct_data)) {
    if(isDefined(var_1.write_to_dlog_runtime_struct_data.targetname)) {
      if(var_1.write_to_dlog_runtime_struct_data.targetname == "train_wz") {
        var_0.moving_platform = var_1;
        return;
      }

      return;
    }

    return;
  }

  if(isDefined(var_1.targetname) && var_1.targetname == "train_wz") {
    var_0.moving_platform = var_1;
    return;
  }
}

function playerumpedfromplane() {
  self endon("death");
  self endon("start_extract");
  playsoundatpos(self.origin, "fulton_bag_drop");
  thread scripts\mp\gametypes\br::ref_13ac7("br_fulton_device_placed", self.owner, self.team);
  var_0 = scripts\mp\utility\teams::getfriendlyplayers(self.team);
  scripts\mp\gametypes\br_plunder::ref_12796(self, "equip_mp_fulton");
  thread scripts\mp\gametypes\br_plunder::ref_127a4(self, var_0);
  scripts\mp\gametypes\br_plunder::ref_127aa(self, var_0);
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  var_1.angles = self.angles * (0, 1, 0);
  var_1.playerstartpowers = self;
  self.scenenode = var_1;

  if(isDefined(self.moving_platform)) {
    self linkTo(self.moving_platform);
    var_1 linkTo(self.moving_platform);
  }

  playertracking();
  var_2 = scripts\mp\gametypes\br_plunder::ref_1278c("equip_mp_fulton", 1);

  if(var_2.get_chopper_boss_combat_action) {
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

function playerteleportprop(var_0) {
  var_1 = var_0.damage;

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_0.attacker, self.owner))) {
    var_1 = 0;
  } else {
    var_1 = scripts\mp\damage::handleshotgundamage(var_0.objweapon, var_0.meansofdeath, var_0.damage);
    var_2 = undefined;

    if(var_0.meansofdeath == "MOD_MELEE") {
      var_1 = int(ceil(self.maxhealth / 6));
    } else if(isexplosivedamagemod(var_0.meansofdeath)) {
      if(var_0.damage >= 50) {
        var_1 = int(ceil(self.maxhealth / 2));
      }
    }
  }

  return var_1;
}

function playerteleporttoloc(var_0) {
  thread playerswithoutdismemberment(var_0);
}

function playerusehealslot(var_0, var_1, var_2) {
  var_3 = scripts\mp\gametypes\br_plunder::ref_1278c("equip_mp_fulton");
  var_1 thread scripts\mp\gametypes\br_plunder::ref_1261f(var_2, var_3.ref_14077, var_0);
}

function playerupdatebesttimehud(var_0, var_1) {
  if(isDefined(var_0.owner)) {
    var_0.owner.playerstartpowers = undefined;
  }

  scripts\mp\gametypes\br_plunder::ref_1279d(var_0);
}

function playerupdatehudstate(var_0) {
  var_0 endon("death");
  var_1 = scripts\mp\gametypes\br_plunder::ref_1278c("equip_mp_fulton");
  var_2 = undefined;
  var_0 scripts\mp\damage::monitordamageend();
  var_2 = scripts\mp\gametypes\br_plunder::num_players_in_safehouse();
  thread scripts\mp\gametypes\br::ref_13ac7("br_fulton_balloon_successfully_away", self.owner, self.team);
  self notify("fulton_takeoff");
  self playsoundonmovingent("br_fulton_balloon_away");
  self.scenenode scripts\common\anim::anim_single_solo(self, "fulton_takeoff");
  thread playerswapteam();
}

function playerupdatealivecounthuman(var_0) {
  thread scripts\mp\gametypes\br::ref_13ac7("br_fulton_balloon_full", var_0.owner, var_0.team);
}

function playerstreamhintdroptoground(var_0) {
  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return true;
  }

  var_1 = 25;
  var_2 = scripts\cp_mp\parachute::getc130height();
  var_3 = var_0.origin + (0, 0, var_1 + 1);
  var_4 = (var_0.origin[0], var_0.origin[1], var_2);
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_6 = scripts\engine\trace::sphere_trace(var_3, var_4, var_1, var_0, var_5);
  return var_6["fraction"] == 1;
}

function playerunpackdatafromomnvar() {
  self setweaponammoclip(self.super.staticdata.weapon, 1);
  self notify("super_use_finished_lb");
  self notify("super_use_finished");
  scripts\cp\vehicles\vehicle_compass_cp::ref_12097(self.super, 1);
  var_0 = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::ref_131c7(0);
  scripts\mp\supers::ref_131c6(0);
  var_0.wasrefunded = 1;
  scripts\mp\supers::setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded());
}