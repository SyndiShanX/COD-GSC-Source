/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\slinger.gsc
***********************************************/

function slinger_init() {
  slinger_initanims();
  slinger_initparams();
  scripts\mp\utility\sound::besttime("equip_skyhook");
  level.slingers = [];
  scripts\engine\scriptable::ref_12f5b("balloon_use_cache", &slingerscriptableused);
}

#using_animtree("");

function slinger_initanims() {
  level.scr_animtree["slinger"] = #animtree;
  level.scr_anim["slinger"]["slinger_open"] = $wm_portable_redeploy_balloon_open;
  level.scr_animname["slinger"]["slinger_open"] = "wm_portable_redeploy_balloon_open";
  level.scr_anim["slinger"]["slinger_open_idle"] = % wm_portable_redeploy_balloon_idle;
  level.scr_animname["slinger"]["slinger_open_idle"] = "wm_portable_redeploy_balloon_idle";
}

function slinger_initparams() {
  level.slingerparams = spawnStruct();
  level.slingerparams.ascentheight = getdvarint("scr_slinger_ascent_height", 2500);
  level.slingerparams.ascenttime = getdvarint("scr_slinger_ascent_time", 2);
  level.slingerparams.launchforwardscalar = getdvarfloat("scr_slinger_launch_forward_scalar", 1250);
  level.slingerparams.launchzscalar = getdvarfloat("scr_slinger_launch_z_scalar", 1500);
  level.slingerparams.launchtime = getdvarfloat("scr_slinger_launch_time", 1);
  level.slingerparams.slingerhealth = getdvarint("scr_slinger_health", 1250);
  level.slingerparams.explosivesmultiplier = getdvarint("scr_slinger_explosives_multiplier", 4);
  level.slingerparams.aaturretmultiplier = getdvarint("scr_slinger_aa_turret_multiplier", 6);
  level.slingerparams.thermitedps = getdvarint("scr_slinger_thermite_dps", 100);
  level.slingerparams.cantakedamage = loadfx("vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_scrnfx");
  level.slingerparams.explosionfx = loadfx("vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_explosion_port");
  level.slingerparams.ref_127e6 = loadfx("vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_timeout_port");
  level.slingerparams.destroyedfx = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_jammer_dmg.vfx");
}

function slinger_allow_use() {
  return true;
}

function slinger_used(var_0) {
  var_1 = self;
  var_1 endon("death_or_disconnect");
  jumpiffalse(getdvarint("scr_slinger_use_time_debug", 1) > 0 && isDefined(var_1.super)) LOC_00000039;
  var_1.super.slingerthrowtime = gettime();
  var_0 waittill("missile_stuck", var_2);
  var_3 = undefined;

  if(isDefined(var_2) || !scripts\mp\outofbounds::unset_relic_rocket_kill_ammo(var_0.origin)) {
    var_3 = "MP_BR_INGAME_TU_WZ345/SLINGER_CANNOT_PLACE";
  } else if(level.slingers.size >= 8 || isDefined(var_1.slingers) && var_1.slingers.size >= 3) {
    var_3 = "MP_BR_INGAME_TU_WZ345/SLINGER_TOO_MANY";
  } else if(!slinger_hasdeployclearance(var_1, var_0)) {
    var_3 = "MP_BR_INGAME_TU_WZ345/SLINGER_BLOCKED";
  }

  if(isDefined(var_3)) {
    var_1 playlocalsound("br_pickup_deny");
    var_1 scripts\mp\hud_message::showerrormessage(var_3);

    if(isDefined(var_1.super)) {
      slinger_refundsuper(var_1);
    }

    var_0 delete();
    return;
  }

  slinger_deploy(var_1, var_0);
}

function slinger_refundsuper() {
  var_0 = self;
  var_1 = 1;
  var_0 setweaponammoclip(var_0.super.staticdata.weapon, var_1);

  if(istrue(var_0.issuperdisabled)) {
    var_0.loadoutextraperksfromgamemode = var_1;
  }

  var_0 notify("super_use_finished_lb");
  var_0 notify("super_use_finished");
  scripts\cp\vehicles\vehicle_compass_cp::ref_12097(var_0.super, 1);
  var_2 = var_0 scripts\mp\supers::getcurrentsuper();
  var_0 scripts\mp\supers::ref_131c7(0);
  var_0 scripts\mp\supers::ref_131c6(0);
  var_2.wasrefunded = 1;
  var_0 scripts\mp\supers::setsuperbasepoints(var_0 scripts\mp\supers::getsuperpointsneeded());
}

function slinger_hasdeployclearance(var_0) {
  var_1 = 32;
  var_2 = var_0.origin + (0, 0, var_1 + 1);
  var_3 = var_0.origin + (0, 0, 4500);
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_5 = scripts\engine\trace::sphere_trace(var_2, var_3, var_1, var_0, var_4);
  return var_5["fraction"] == 1;
}

function slinger_deploy(var_0) {
  var_1 = self;

  if(isDefined(var_1.super)) {
    if(getdvarint("scr_slinger_use_time_debug", 1) > 0 && !isDefined(var_1.super.usestarttime)) {
      var_2 = "unknown";

      if(isDefined(var_1.super.staticdata)) {
        var_2 = scripts\engine\utility::ter_op(isDefined(var_1.super.staticdata.ref), var_1.super.staticdata.ref, "undefined");
      }

      var_3 = scripts\engine\utility::ter_op(isDefined(var_1.super.slingerthrowtime), var_1.super.slingerthrowtime, "undefined");
      var_4 = scripts\engine\utility::ter_op(isDefined(var_1.super.madeavailabletime), var_1.super.madeavailabletime, "undefined");
      var_5 = scripts\engine\utility::ter_op(isDefined(var_1.super.usepercent), var_1.super.usepercent, "undefined");
      var_6 = "Portable redeploy balloon undefined useStartTime. ref[" + var_2 + "] throwTime[" + var_3 + "] madeAvailableTime[" + var_4 + "] usePercent[" + var_5 + "]";
      scripts\mp\utility\script::laststand_dogtags(var_6);
    }

    var_1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
  }

  var_7 = var_0.origin;
  var_8 = var_0.angles * (0, 1, 0);
  var_0 delete();
  var_9 = spawn("script_model", var_7);
  var_9 getuseholdkbmprofile(1);
  var_9 setModel("military_skyhook_depballoon_backpack");
  var_9.angles = var_8;
  var_9.animname = "slinger";
  var_9 scripts\common\anim::setanimtree();
  var_9.owner = var_1;
  var_9.team = var_1.team;
  var_9.ascendingplayers = [];
  var_9.ascenderscenenodes = [];
  var_9.ascenderviewmodels = [];
  var_9.ascenderworldmodels = [];
  var_9.isslingermodel = 1;
  thread run_deployed_slinger(var_9);
}

function run_deployed_slinger(var_0) {
  var_1 = self;
  var_1 endon("death");

  if(!isDefined(var_0.slingers)) {
    var_0.slingers = [];
  }

  var_0.slingers[var_0.slingers.size] = var_1;
  playsoundatpos(var_1.origin, "fulton_bag_drop");
  playsoundatpos(var_1.origin, "skyhook_deploy");
  playsoundatpos(var_1.origin + (0, 0, 400), "skyhook_rope_deploy_start");
  thread slinger_collision_watcher();
  thread slinger_damage_watcher();
  thread drop_players_on_break_watcher();
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles * (0, 1, 0));
  var_1.scenenode = var_2;
  thread slinger_use_activate();
  var_2 scripts\common\anim::anim_single_solo(var_1, "slinger_open");
  thread run_slinger_idle_anim(var_1);
  playsoundatpos(var_1.origin + (0, 0, 4500), "skyhook_balloon_inflate");
  var_1.laststandplayers = 1;
  var_3 = getdvarfloat("scr_slinger_deploy_duration", 30);
  var_4 = var_1 scripts\engine\utility::ref_143b9(var_3, "slinger_destroyed");

  if(var_4 == "timeout") {
    playFX(level.slingerparams.ref_127e6, var_1.origin + (0, 0, 4500));
    playsoundatpos(var_1.origin + (0, 0, 4500), "skyhook_pop");
  } else {
    playFX(level.slingerparams.explosionfx, var_1.origin + (0, 0, 4500));
    playsoundatpos(var_1.origin + (0, 0, 4500), "skyhook_explode");
  }

  playFX(level.slingerparams.destroyedfx, var_1.origin);
  playsoundatpos(var_1.origin, "mp_equip_destroyed");

  if(isDefined(var_0) && isDefined(var_0.slingers)) {
    var_0.slingers = scripts\engine\utility::array_remove(var_0.slingers, var_1);
  }

  var_2 delete();
  var_1 delete();
}

function slinger_use_activate() {
  var_0 = self;
  var_0 endon("death");
  level endon("game_ended");
  wait 0.5;
  var_0 setscriptablepartstate("balloon_use_cache", "usable");
  var_0 setscriptablepartstate("balloon_objective", "active");
}

function slinger_collision_watcher() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_1 = 0.5;
  var_2 = 2500;
  var_3 = 0.15;
  var_4 = 99999;
  wait var_1;
  var_0 physics_registerforcollisioncallback();
  var_0 method_87de(1);

  for(;;) {
    var_0 waittill("collision", var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(var_9[2] > var_0.origin[2] + var_2 && isDefined(var_12) && var_12 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_12 scripts\engine\utility::delaycallwatchself(var_3, &dodamage, var_4, var_9);
      var_0 notify("slinger_destroyed");
    }
  }
}

function slinger_damage_watcher() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.scripthealth = level.slingerparams.slingerhealth;
  var_0.health = 99999;
  var_0.maxhealth = 99999;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health += var_1;

    if(isDefined(var_10) && isDefined(var_10.magazine)) {
      switch (var_10.magazine) {
        case "calcust1_xmike109":
          var_1 = 300;
          break;
        case "calcust2_xmike109":
          thread fake_thermite_damage_duration(var_0, 3, var_2);
          break;
      }
    }

    if(isPlayer(var_2)) {
      var_2 scripts\mp\damagefeedback::updatehitmarker("standard", var_0.health == 0, 0, 1, "hitequip");
    } else if(isDefined(var_2.owner) && isPlayer(var_2.owner)) {
      var_2.owner scripts\mp\damagefeedback::updatehitmarker("standard", var_0.health == 0, 0, 1, "hitequip");
    }

    if(isDefined(var_2) && isDefined(var_2.currentweapon) && isDefined(var_2.currentweapon.basename) && var_2.currentweapon.basename == "manual_turret_flak_mp") {
      var_1 *= level.slingerparams.aaturretmultiplier;
    } else if(isDefined(var_5) && var_5 == "MOD_PROJECTILE" || var_5 == "MOD_GRENADE" || var_5 == "MOD_EXPLOSIVE" || var_5 == "MOD_EXPLOSIVE_BULLET") {
      var_1 *= level.slingerparams.explosivesmultiplier;
    }

    if(isDefined(var_10) && isDefined(var_10.basename) && var_10.basename == "toma_proj_mp") {
      var_1 = var_0.scripthealth + 1;
    }

    var_0.scripthealth -= var_1;

    if(var_0.scripthealth <= 0) {
      break;
    }

    if(isDefined(var_10) && isDefined(var_10.magazine)) {
      switch (var_10.magazine) {
        case "boltexplo_crossbow":
          scripts\engine\utility::delaycallwatchself(2.05, &dodamage, var_1, var_4, var_2, undefined, undefined, undefined, var_4);
          break;
        case "boltfire_crossbow":
          scripts\engine\utility::delaycallwatchself(4, &dodamage, var_1, var_4, var_2, undefined, undefined, undefined, var_4);
          break;
      }
      LOC_00000291:
    }
    LOC_00000291:
  }

  if(isDefined(var_2.model) && var_2.model == "veh_s4_mil_air_dalpha_wz_turret_attach" && isDefined(var_2.owner) && isPlayer(var_2.owner)) {
    var_2.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]]("kill", 500);
  }

  if(isDefined(var_2) && isPlayer(var_2) && isDefined(var_2.currentweapon) && isDefined(var_2.currentweapon.basename) && var_2.currentweapon.basename == "tur_gun_bt_mp") {
    var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]]("kill", 500);
  }

  var_0 notify("slinger_destroyed");
}

function fake_thermite_damage_duration(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_4 = 0;

  while(var_4 < var_0) {
    wait 0.25;

    if(scripts\mp\utility\player::isreallyalive(var_1)) {
      var_1 scripts\mp\damagefeedback::updatehitmarker("standard", 0, 0, 1, "hitequip");
    }

    var_4 += 0.25;
  }

  var_3 dodamage(level.slingerparams.thermitedps * var_0, var_2, var_1, undefined, undefined, undefined, var_2);
}

function drop_players_on_break_watcher() {
  var_0 = self;
  var_0 waittill("death");

  foreach(var_2 in var_0.ascendingplayers) {
    var_3 = var_2 getentitynumber();
    var_4 = var_0.ascenderscenenodes[var_3];
    var_4 thread scripts\mp\gametypes\br_skyhook::ref_133fc(var_2);
    var_4 stoploopsound("br_auto_ascender_device_lp_npc");
    slingerfullcleanup(var_2, var_3, var_0);
  }
}

function run_slinger_idle_anim(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_0 endon("death");

  for(;;) {
    var_0 scripts\common\anim::anim_single_solo(var_1, "slinger_open_idle");
  }
}

function slingerscriptableused(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "usable") {
    if(!canplayeruseslinger(var_0, var_3)) {
      return;
    }

    if(getdvarint("scr_slinger_carriable_interaction_enabled", 1) && isDefined(var_3.get_search_turret_target_player) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "carriable_useSkyhook")) {
      var_0.chopperexfil_sfx_before_sh070 = var_0.entity;
      var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "carriable_useSkyhook")]](var_0);
      return;
    }

    thread useslinger(var_3);
    return;
  }
}

function canplayeruseslinger(var_0, var_1) {
  if(istrue(var_0.inuse)) {
    return false;
  }

  if(var_1 isswitchingweapon()) {
    return false;
  }

  if(var_1.currentweapon.basename == "iw8_spotter_scope_mp_ch3") {
    return false;
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(istrue(var_1.tracking_max_health)) {
    return false;
  }

  if(istrue(var_1.inlaststand)) {
    return false;
  }

  if(istrue(var_1.isreviving)) {
    return false;
  }

  if(istrue(var_1.isjuggernaut)) {
    return false;
  }

  if(var_1 isskydiving()) {
    return false;
  }

  if(var_1 isparachuting()) {
    return false;
  }

  if(istrue(var_1.iszombie)) {
    return false;
  }

  if(!var_1 scripts\common\utility::trial_ui_retry_disabled()) {
    return false;
  }

  return true;
}

function useslinger(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_2 = var_0.entity;
  var_2 endon("death");
  var_2.ascendingplayers[var_2.ascendingplayers.size] = var_1;
  var_1.ref_140af = 1;
  var_1.shouldskiplaststand = 1;

  if(isDefined(var_1.get_search_turret_target_player)) {
    var_1.get_search_turret_target_player thread scripts\mp\equipment\binoculars::get_subway_train_hit_damage_multiplier(0);
  }

  scripts\mp\gametypes\br_skyhook::ref_1246f(var_1);
  var_1 scripts\common\utility::allow_usability(0);
  var_0 thread scripts\mp\gametypes\br_skyhook::ref_13405();
  var_1.usingascender = 1;
  var_3 = var_1 getentitynumber();
  var_4 = spawn("script_model", var_0.origin);
  var_4 setModel("tag_origin");
  var_4 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_2.ascenderscenenodes[var_3] = var_4;
  var_4 dontinterpolate();
  var_4.origin = var_0.origin;
  var_4.angles = var_1.angles;
  var_5 = spawn("script_model", var_0.origin);
  var_5 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_5 setModel("misc_vm_ascender_ch3");
  var_5 showonlytoplayer(var_1);
  var_2.ascenderviewmodels[var_3] = var_5;
  var_6 = spawn("script_model", var_0.origin);
  var_6 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_6 setModel("misc_vm_ascender_ch3");
  var_6 hide();
  var_2.ascenderworldmodels[var_3] = var_6;
  thread slingerascendingdeathlistener(var_1, var_0);
  var_1.slingerdofreefall = 0;
  var_7 = var_4 scripts\mp\gametypes\br_skyhook::ref_133fb(var_1, var_5, var_6);

  if(!var_7) {
    slingerfullcleanup(var_1, var_3, var_2);
    playsoundatpos(var_0.origin, "skyhook_repair_denied");
    return;
  }

  var_1 childthread scripts\mp\gametypes\br_skyhook::ref_133fe();
  var_1 thread scripts\mp\gametypes\br_skyhook::ref_12505();
  var_4 thread scripts\mp\gametypes\br_skyhook::ref_133fd(var_1, var_5, var_6);
  var_4 playLoopSound("br_auto_ascender_device_lp_npc");
  var_4 moveTo(var_4.origin + (0, 0, level.slingerparams.ascentheight), level.slingerparams.ascenttime, level.slingerparams.ascenttime);
  playfxontagforclients(level.slingerparams.cantakedamage, var_4, "tag_origin", var_1);
  wait level.slingerparams.ascenttime * 0.35;
  var_1.slingerdofreefall = 1;
  wait level.slingerparams.ascenttime * 0.65;
  stopFXOnTag(level.slingerparams.cantakedamage, var_4, "tag_origin");
  var_1 notify("kill_skyhook_ascend_earthquake");
  var_4 thread scripts\mp\gametypes\br_skyhook::ref_133fc(var_1, var_5, var_6);
  var_4 stoploopsound("br_auto_ascender_device_lp_npc");
  var_1 playlocalsound("scr_br_infil_jump_stinger", var_1);
  var_1 earthquakeforplayer(0.2, 1.5, var_1.origin, 1000);
  var_8 = "enabled";

  if(isDefined(var_1.operatorcustomization) && isDefined(var_1.operatorcustomization.disabledebugdialogue)) {
    var_8 += var_1.operatorcustomization.disabledebugdialogue;
  }

  var_1 setscriptablepartstate("skydiveVfx", var_8, 0);
  var_1 setisinfilskydive(1);
  var_1.slingerlaunchvelocity = anglesToForward(var_1 getplayerangles(1)) * level.slingerparams.launchforwardscalar;
  var_4 movegravity(var_1.slingerlaunchvelocity + (0, 0, level.slingerparams.launchzscalar), level.slingerparams.launchtime);
  wait level.slingerparams.launchtime - 0.1;
  var_1 setclientomnvar("ui_br_altimeter_state", 1);
  var_1 thread scripts\mp\gametypes\br_skyhook::ref_13403();
  slingerfullcleanup(var_1, var_3, var_2);
  var_2.ascendingplayers = scripts\engine\utility::array_remove(var_2.ascendingplayers, var_1);
}

function slingerascendingdeathlistener(var_0, var_1) {
  var_2 = self;
  var_2 endon("slinger_complete");
  scripts\engine\utility::waittill_any_ents(self, "death_or_disconnect", self, "last_stand_start", level, "game_ended");

  if(isDefined(var_2)) {
    var_2 stopanimscriptsceneevent();
  }

  var_3 = var_0.entity;
  var_3.ascenderscenenodes[var_1] stoploopsound("br_auto_ascender_device_lp_npc");
  var_3.ascendingplayers = scripts\engine\utility::array_remove(var_3.ascendingplayers, var_2);
  slingerfullcleanup(var_2, var_1, var_3);
}

function slingerfullcleanup(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 setscriptablepartstate("skydiveVfx", "default", 0);
    var_0 setisinfilskydive(0);
  }

  if(isDefined(var_2.ascenderviewmodels[var_1])) {
    var_2.ascenderviewmodels[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    var_2.ascenderviewmodels[var_1] delete();
  }

  if(isDefined(var_2.ascenderworldmodels[var_1])) {
    var_2.ascenderworldmodels[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    var_2.ascenderworldmodels[var_1] delete();
  }

  var_2 thread scripts\mp\gametypes\br_skyhook::cleanupascenduse(var_0);
  thread scenenodecleanup(var_2, var_0);

  if(isDefined(var_0)) {
    if(!istrue(level.client_activate)) {
      var_0 skydive_setbasejumpingstatus(1);
    }

    var_0.player_rig stopanimScripted();
    var_0.usingascender = 0;
    var_0.ref_140af = 0;
    var_0 notify("kill_skyhook_ascend_earthquake");

    if(isDefined(var_0.slingerlaunchvelocity)) {
      var_0 setvelocity(var_0.slingerlaunchvelocity);
    }

    var_0.slingerlaunchvelocity = undefined;

    if(istrue(var_0.slingerdofreefall) && !istrue(level.client_activate) && !scripts\mp\utility\player::unset_relic_trex(var_0)) {
      var_0 skydive_beginfreefall();
    }

    var_0 notify("slinger_complete");
    return;
  }
}

function scenenodecleanup(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_0)) {
    var_0 unlink();

    if(!var_0 scripts\common\utility::can_be_executed()) {
      var_0 scripts\common\utility::allow_execution_victim(1);
    }
  }

  if(isDefined(var_2.ascenderscenenodes[var_1])) {
    var_2.ascenderscenenodes[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    var_2.ascenderscenenodes[var_1] delete();
    return;
  }
}