/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_ark.gsc
**************************************/

main() {
  maps\mp\mp_zombie_ark_precache::main();
  maps\createart\mp_zombie_ark_art::main();
  maps\mp\mp_zombie_ark_fx::main();
  maps\mp\mp_zombie_ark_sq::createfxhidesidquestents();
  maps\mp\_load::main();
  maps\mp\mp_zombie_ark_lighting::main();
  maps\mp\mp_zombie_ark_aud::main();
  maps\mp\mp_zombie_ark_sq::init_sidequest();
  maps\mp\_compass::setupminimap("compass_map_mp_zombie_ark");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.dlcleaderboardnumber = 3;
  level.pickupdebugprint = 1;
  level.zombiehostinit = maps\mp\zombies\zombie_host::init;
  level.zombiedoginit = maps\mp\zombies\zombie_dog::init;
  level.zombielevelinit = ::initark;
  level.agentshouldragdollimmediatelyfunc = ::agentshouldragdollimmediately;
  level thread flyoverbink();
  visionsetpain("mp_zombie_ark_pain", 0);
  level.zombieinfectedvisionset = "mp_zombie_ark_infected";
  level.zombieinfectedvisionset2 = "mp_zombie_ark_infected_uber";
  level.zombieinfectedlightset = "mp_zombie_ark_infected";
  level.zombies_using_civilians = 0;
  level.allow_swimming = 0;
  level thread maps\mp\_water::init();
  thread disablepronevolumecheck();
  level.nearestnodetounreachabledronesearchheight = 128;
  thread initzones();
  thread initcharactermodels();
  thread initarkmutators();
  thread maps\mp\zombies\_pickups_dlc3::init();
  thread maps\mp\zombies\zombie_ammo_drone::init();
  thread maps\mp\zombies\_zombies_audio_dlc3::initdlc3audio();
  thread initareainvalidation();
  thread doidlesharkanimations();
  thread killglass();
  thread zombiearkloadeyeeffects();
  thread exoreveal();
  level.airdropcustomfunclevelspecific = ::airdropcustomfunc;
  level.zmgetscorestreaksforschedule = ::getscorestreaksforschedule;
  level.zombieweapononplayerspawnedfunc = ::zombieweapononplayerspawned;
  level.zombieweaponinitfunc = ::zombieweaponinit;
  level.initmagicboxweaponsfunc = ::zombiearkinitmagicboxweapons;
  level.onstartgametypelevelfunc = ::zombiearkstartgametypelevel;
  level.calculatespecialroundtypeoverride = ::calculatespecialroundtype;
  level.givecustomcharacters = ::zombiearkgivecustomcharacter;
  level.filterstartspawnfunc = ::zombiearkfilterstartspawns;
  level.filterrespawnfunc = ::zombiearkfilterrespawns;
  level.zmcustomdamagetriggerweapon = ::zmcustomdamagetriggerweapon;
  level.zmbteleportgrenadefindzonecustom = ::zmbteleportgrenadefindzonecustom;
  level.zmteleporterinit = ::zmteleporterinit;
  level.zmteleporterused = ::zmteleporterused;
  level.zmteleporterroomenter = ::zmteleporterroomenter;
  level.zmteleporterplayers = ::zmteleporterplayers;
  level.zmteleportreadyhint = &"ZOMBIE_ARK_TELEPORT_USE";
  level.zmteleportlookarcs = [0, 0, 0, 0];
  level.zmdamageignoresarmor = maps\mp\gametypes\zombies::zmdamageignoresarmor;
  level.canspawnpickupoverridefunc = maps\mp\zombies\_pickups_dlc3::canspawnpickup;
  level.allowzombierecycle = 1;
  level.recyclefullhealthzombies = 1;
  level.zmblasertrapcustom = "trap_ark_zm";
  level.zmblasertrapwarningcustom = "trap_ark_zm_warning";
  level.zmblasertrapsoundloop = "trap_scanner_beam_lp";
  level.zmblasertrapsoundstop = "trap_scanner_off_shot";
  level.zmblasertrapsoundstart = "trap_scanner_on_shot";
  level.modifygenericzombieclassfunc = ::zombiearkmodifygenericzombieclass;

  if(level.nextgen) {
    thread spawnpatchclipfixes();
  } else {
    thread triggerscriptpatchkilltrigger();
  }

  level.zmpatchshovefunc = ::zombiearkpatchshove;
}

triggerscriptpatchkilltrigger() {}

spawnkilltriggerthink(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = spawn("trigger_radius", var_0, 0, var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  for(;;) {
    var_3 waittill("trigger", var_4);

    if(isDefined(var_4) && isPlayer(var_4) && isDefined(var_4.health)) {
      var_4 dodamage(var_4.health + 999, var_3.origin);
    }
  }
}

zombiearkmodifygenericzombieclass(var_0) {
  var_1 = var_0.model_bodies.size;

  if(level.nextgen) {
    var_0.model_bodies[var_1] = ["zom_worker_torso_slice"];
    var_0.model_limbs[var_1]["right_arm"] = ["zom_worker_r_arm_slice"];
    var_0.model_limbs[var_1]["left_arm"] = ["zom_worker_l_arm_slice"];
    var_0.model_limbs[var_1]["right_leg"] = ["zom_worker_r_leg_slice"];
    var_0.model_limbs[var_1]["left_leg"] = ["zom_worker_l_leg_slice"];
    var_0.model_heads[var_1] = ["zombies_head_cau_worker_dlc3_a", "zombies_head_cau_worker_dlc3_b", "zombies_head_cau_worker_dlc3_c"];
    var_1++;
    var_0.model_bodies[var_1] = ["zom_worker_b_torso_slice"];
    var_0.model_limbs[var_1]["right_arm"] = ["zom_worker_b_r_arm_slice"];
    var_0.model_limbs[var_1]["left_arm"] = ["zom_worker_b_l_arm_slice"];
    var_0.model_limbs[var_1]["right_leg"] = ["zom_worker_b_r_leg_slice"];
    var_0.model_limbs[var_1]["left_leg"] = ["zom_worker_b_l_leg_slice"];
    var_0.model_heads[var_1] = ["zombies_head_cau_worker_dlc3_a", "zombies_head_cau_worker_dlc3_b", "zombies_head_cau_worker_dlc3_c"];
    level.exobodyparts["zom_worker_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_worker_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_worker_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_worker_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_worker_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
    level.exobodyparts["zom_worker_torso_slice"]["heads"] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b"];
    level.exobodyparts["zom_worker_b_torso_slice"]["torso"] = "zom_marine_exo_torso_slice_ab";
    level.exobodyparts["zom_worker_b_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_worker_b_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_worker_b_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice_ab";
    level.exobodyparts["zom_worker_b_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice_ab";
    level.exobodyparts["zom_worker_b_torso_slice"]["heads"] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b"];
    level.dismemberment["zombies_head_cau_worker_dlc3_a"]["nub"] = "zom_worker_head_slice";
    level.dismemberment["zombies_head_cau_worker_dlc3_b"]["nub"] = "zom_worker_head_slice";
    level.dismemberment["zombies_head_cau_worker_dlc3_c"]["nub"] = "zom_worker_head_slice";
    return var_0;
  } else {
    var_0.model_bodies[var_1] = ["zom_worker_torso_slice"];
    var_0.model_limbs[var_1]["right_arm"] = ["zom_worker_r_arm_slice"];
    var_0.model_limbs[var_1]["left_arm"] = ["zom_worker_l_arm_slice"];
    var_0.model_limbs[var_1]["right_leg"] = ["zom_worker_r_leg_slice"];
    var_0.model_limbs[var_1]["left_leg"] = ["zom_worker_l_leg_slice"];
    var_0.model_heads[var_1] = ["zombies_head_cau_worker_dlc3_a"];
    level.exobodyparts["zom_worker_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_worker_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_worker_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_worker_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_worker_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
    level.exobodyparts["zom_worker_torso_slice"]["heads"] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b"];
    level.dismemberment["zombies_head_cau_worker_dlc3_a"]["nub"] = "zom_worker_head_slice";
    return var_0;
  }
}

zombiearkloadeyeeffects() {
  level.validheadtypes[level.validheadtypes.size] = "cau_worker_dlc3_a";
  level.validheadtypes[level.validheadtypes.size] = "cau_worker_dlc3_b";
  level.validheadtypes[level.validheadtypes.size] = "cau_worker_dlc3_c";
  level._effect["zombie_eye_vanilla_cau_worker_dlc3_a"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_vanilla_cau_dlc_a");
  level._effect["zombie_eye_vanilla_cau_worker_dlc3_b"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_vanilla_cau_dlc_b");
  level._effect["zombie_eye_vanilla_cau_worker_dlc3_c"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_vanilla_cau_dlc_c");
}

zmcustomdamagetriggerweapon(var_0, var_1, var_2) {
  if(var_2 == "laser") {
    return "zombie_vaporize_mp";
  } else {
    return "trap_zm_mp";
  }
}

disablepronevolumecheck() {
  level endon("game_ended");
  var_0 = getEntArray("water_no_prone", "targetname");

  foreach(var_2 in var_0) {
    for(;;) {
      var_2 waittill("trigger", var_3);

      if(isPlayer(var_3)) {
        var_3 thread disableprone(var_2);
      }
    }
  }
}

disableprone(var_0) {
  self notify("noprone");
  self endon("noprone");

  while(self istouching(var_0)) {
    self allowprone(0);
    wait 0.5;
  }

  self allowprone(1);
}

initarkmutators() {
  maps\mp\zombies\_mutators::initfastmutator();
  maps\mp\zombies\_mutators::initexplodermutator();
  maps\mp\zombies\_mutators::initemzmutator();
  maps\mp\zombies\_mutators_spiked::initspikedmutator();
  maps\mp\zombies\_mutators_armor::initarmormutator();
  maps\mp\zombies\_mutators_teleport::initteleportmutator();
  level.mutatortablesetupfunc = ::buildmutatortable;
}

initark() {
  maps\mp\zombies\zombie_melee_goliath::init();
  maps\mp\zombies\ranged_elite_soldier::init();
  maps\mp\zombies\killstreaks\_zombie_squadmate::init();
}

initzones() {
  maps\mp\zombies\_zombies_zone_manager::init();
  maps\mp\zombies\_zombies_zone_manager::initializezone("sidebay", 1);
  maps\mp\zombies\_zombies_zone_manager::initializezone("rearbay", 1);
  maps\mp\zombies\_zombies_zone_manager::initializezone("cargo_elevator");
  maps\mp\zombies\_zombies_zone_manager::initializezone("cargo_bay");
  maps\mp\zombies\_zombies_zone_manager::initializezone("armory");
  maps\mp\zombies\_zombies_zone_manager::initializezone("biomed");
  maps\mp\zombies\_zombies_zone_manager::initializezone("medical");
  maps\mp\zombies\_zombies_zone_manager::initializezone("moonpool");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sidebay", "rearbay", "sidebay_to_rearbay");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sidebay", "armory", "sidebay_to_armory");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("rearbay", "armory", "rearbay_to_armory");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("cargo_elevator", "cargo_bay", "cargo_elevator_to_cargo_bay");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("biomed", "cargo_bay", "biomed_to_cargo_bay");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("armory", "biomed", "armory_to_biomed");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("armory", "cargo_elevator", "armory_to_cargo_elevator");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("medical", "biomed", "medical_to_biomed");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("moonpool", "cargo_elevator", "moonpool_to_cargo_elevator");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sidebay", "medical", "sidebay_to_medical");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("rearbay", "moonpool", "rearbay_to_moonpool");
  level thread zoneopensidebaytorearbay();
  maps\mp\zombies\_zombies_zone_manager::activate();
  level.doorbitmaskarray = [];
  level.doorbitmaskarray["sidebay_to_armory"] = 1;
  level.doorbitmaskarray["rearbay_to_armory"] = 2;
  level.doorbitmaskarray["cargo_elevator_to_cargo_bay"] = 4;
  level.doorbitmaskarray["biomed_to_cargo_bay"] = 8;
  level.doorbitmaskarray["armory_to_biomed"] = 16;
  level.doorbitmaskarray["armory_to_cargo_elevator"] = 32;
  level.doorbitmaskarray["medical_to_biomed"] = 64;
  level.doorbitmaskarray["moonpool_to_cargo_elevator"] = 128;
  level.doorbitmaskarray["sidebay_to_medical"] = 256;
  level.doorbitmaskarray["rearbay_to_moonpool"] = 512;
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_SIDEBAY", "sidebay_to_armory", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_ARMORY", "sidebay_to_armory", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_REARBAY", "rearbay_to_armory", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_ARMORY", "rearbay_to_armory", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_CARGOBAY", "cargo_elevator_to_cargo_bay", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_CARGOELEVATOR", "cargo_elevator_to_cargo_bay", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_BIOMED", "biomed_to_cargo_bay", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_CARGOBAY", "biomed_to_cargo_bay", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_BIOMED", "armory_to_biomed", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_ARMORY", "armory_to_biomed", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_ARMORY", "armory_to_cargo_elevator", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_CARGOELEVATOR", "armory_to_cargo_elevator", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_BIOMED", "medical_to_biomed", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_MEDICAL", "medical_to_biomed", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_MOONPOOL", "moonpool_to_cargo_elevator", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_CARGOELEVATOR", "moonpool_to_cargo_elevator", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_SIDEBAY", "sidebay_to_medical", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_MEDICAL", "sidebay_to_medical", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_REARBAY", "rearbay_to_moonpool", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_MOONPOOL", "rearbay_to_moonpool", 1);
}

zoneopensidebaytorearbay() {
  level endon("game_ended");

  for(;;) {
    var_0 = level common_scripts\utility::waittill_any_return("player_given_exo_suit", "player_purchased_teleport_grenade", "zombie_wave_started");

    if(var_0 == "zombie_wave_started" && level.wavecounter < 5) {
      continue;
    }
    break;
  }

  common_scripts\utility::flag_set("sidebay_to_rearbay");
}

initcharactermodels() {
  maps\mp\zombies\_util::initializecharactermodel("security", "security_guard_body", "viewhands_security_guard", ["security_guard_head"]);
  maps\mp\zombies\_util::initializecharactermodel("exec", "executive_body", "viewhands_executive", ["executive_head"]);
  maps\mp\zombies\_util::initializecharactermodel("it", "lilith_body", "viewhands_lilith", ["lilith_head"]);
  maps\mp\zombies\_util::initializecharactermodel("pilot", "pilot_body_nohelmet", "viewhands_pilot_bcambell", ["pilot_head"]);
  maps\mp\zombies\_util::initializecharactermodel("security_exo", "security_guard_body_exo", "viewhands_security_guard_exo", ["security_guard_head"]);
  maps\mp\zombies\_util::initializecharactermodel("exec_exo", "executive_body_exo", "viewhands_executive_exo", ["executive_head"]);
  maps\mp\zombies\_util::initializecharactermodel("it_exo", "lilith_body_exo", "viewhands_lilith_exo", ["lilith_head"]);
  maps\mp\zombies\_util::initializecharactermodel("pilot_exo", "pilot_body_nohelmet_exo", "viewhands_pilot_bcambell_exo", ["pilot_head"]);
  maps\mp\zombies\_util::initializecharactermodel("security_host", "security_guard_body", undefined, ["security_guard_head_z"]);
  maps\mp\zombies\_util::initializecharactermodel("exec_host", "executive_body", undefined, ["executive_head_z"]);
  maps\mp\zombies\_util::initializecharactermodel("it_host", "lilith_body", undefined, ["lilith_head_z"]);
  maps\mp\zombies\_util::initializecharactermodel("pilot_host", "pilot_body_nohelmet", undefined, ["pilot_head_z"]);
}

initareainvalidation() {
  thread maps\mp\zombies\_area_invalidation::init();
  maps\mp\zombies\_area_invalidation::setupzone("sidebay", 90, 1, &"ZOMBIE_ARK_SIDE_BAY", "dlc3_zombie_bomb_sidebay", "dlc3_zombie_bomb_defuse_sidebay", "dlc3_zombie_bomb_detonate_sidebay");
  maps\mp\zombies\_area_invalidation::setupzone("rearbay", 91, 2, &"ZOMBIE_ARK_REAR_BAY", "dlc3_zombie_bomb_rearbay", "dlc3_zombie_bomb_defuse_rearbay", "dlc3_zombie_bomb_detonate_rearbay");
  maps\mp\zombies\_area_invalidation::setupzone("medical", 97, 3, &"ZOMBIE_ARK_MEDICAL", "dlc3_zombie_bomb_medical", "dlc3_zombie_bomb_defuse_medical", "dlc3_zombie_bomb_detonate_medical", 1);
  maps\mp\zombies\_area_invalidation::setupzone("armory", 92, 4, &"ZOMBIE_ARK_ARMORY", "dlc3_zombie_bomb_armory", "dlc3_zombie_bomb_defuse_armory", "dlc3_zombie_bomb_detonate_armory");
  maps\mp\zombies\_area_invalidation::setupzone("moonpool", 93, 5, &"ZOMBIE_ARK_MOON_POOL", "dlc3_zombie_bomb_moonpool", "dlc3_zombie_bomb_defuse_moonpool", "dlc3_zombie_bomb_detonate_moonpool", 1);
  maps\mp\zombies\_area_invalidation::setupzone("biomed", 94, 6, &"ZOMBIE_ARK_BIOMED", "dlc3_zombie_bomb_biomed", "dlc3_zombie_bomb_defuse_biomed", "dlc3_zombie_bomb_detonate_biomed");
  maps\mp\zombies\_area_invalidation::setupzone("cargo_bay", 95, 7, &"ZOMBIE_ARK_CARGO_ROOM", "dlc3_zombie_bomb_cargobay", "dlc3_zombie_bomb_defuse_cargobay", "dlc3_zombie_bomb_detonate_cargobay");
  maps\mp\zombies\_area_invalidation::setupzone("cargo_elevator", 96, 8, &"ZOMBIE_ARK_CARGO_ELEVATOR", "dlc3_zombie_bomb_cargoelevator", "dlc3_zombie_bomb_defuse_cargoelevator", "dlc3_zombie_bomb_detonate_cargoelevator");
}

airdropcustomfunc() {
  maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault", "repulsion_turret", 8, maps\mp\zombies\killstreaks\_zombie_killstreaks::killstreakcratethink, &"KILLSTREAKS_DLC3_DISRUPTOR_TURRET", "zm_disruptor");
  maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault", "squadmate", 25, maps\mp\zombies\killstreaks\_zombie_killstreaks::killstreakcratethink, &"ZOMBIE_SQUADMATE_SQUADMATE", "zm_squadmate");
}

getscorestreaksforschedule() {
  var_0 = [];
  var_0[var_0.size] = "sentry_" + randomintrange(1, 4);
  var_0[var_0.size] = "drone_" + randomintrange(1, 3);
  var_0[var_0.size] = "money";
  var_0[var_0.size] = "camo";
  var_0[var_0.size] = "squadmate";
  var_0[var_0.size] = "repulsion_turret";
  var_0[var_0.size] = "sentry_" + randomintrange(1, 4);
  var_0[var_0.size] = "drone_" + randomintrange(1, 3);
  var_0[var_0.size] = "money";
  var_0[var_0.size] = "camo";
  var_0[var_0.size] = "squadmate";
  var_0[var_0.size] = "repulsion_turret";
  return var_0;
}

zombieweapononplayerspawned() {
  thread maps\mp\zombies\weapons\_zombie_repulsor::onplayerspawn();
  thread maps\mp\zombies\weapons\_zombie_teleport_grenade::onplayerspawn();
  thread maps\mp\zombies\weapons\_zombie_line_gun::onplayerspawn();
}

zombieweaponinit() {
  maps\mp\zombies\weapons\_zombie_repulsor::init();
  maps\mp\zombies\weapons\_zombie_teleport_grenade::init();
  maps\mp\zombies\weapons\_zombie_line_gun::init();
}

zombiearkinitmagicboxweapons() {
  maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_linegunzm", "npc_zom_line_gun_holo", &"ZOMBIE_WEAPON_LINEGUN_PICKUP", "none", "none", "none", 2);
  maps\mp\zombies\_wall_buys::addmagicboxweapon("repulsor_zombie", "dlc3_repulsor_device_01_holo", &"ZOMBIE_DLC3_REPULSOR", "none", "none", "none", 2);
  maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_dlcgun2zm", "npc_lmg_shotgun_base_static_holo", &"ZOMBIE_WEAPONDLC2_GUN", "none", "none", "none");
  maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_dlcgun3zm", "npc_m1_irons_base_static_holo", &"ZOMBIE_WEAPONDLC3_GUN", "none", "none", "none");
}

buildmutatortable() {
  for(;;) {
    level.special_mutators = [];
    level waittill("zombie_round_countdown_started");
    var_0 = arkgeneratepossiblemutatorsforwave(level.wavecounter);

    foreach(var_3, var_2 in var_0) {
      level.special_mutators[var_3] = [::arkmutatoralwaysvalid, var_2["weight"]];
    }

    level waittill("zombie_wave_ended");
  }
}

arkmutatoralwaysvalid(var_0) {
  return 1;
}

arkgetsolowaveoffset() {
  if(level.players.size < 2) {
    return maps\mp\zombies\zombies_spawn_manager::getsolowaveoffset();
  }

  return 0;
}

arkgeneratepossiblemutatorsforwave(var_0) {
  var_0 = var_0 - arkgetsolowaveoffset();
  var_1 = [];

  if(var_0 < 4) {} else if(var_0 == 4) {
    var_1["emz"]["weight"] = 1;
  } else if(var_0 == 5) {
    var_1["emz"]["weight"] = 1;
    var_1["fast"]["weight"] = 1;
  } else if(var_0 == 6) {
    var_1["emz"]["weight"] = 2;
    var_1["fast"]["weight"] = 1;
    var_1["teleport"]["weight"] = 1;
  } else if(var_0 == 7) {
    var_1["emz"]["weight"] = 4;
    var_1["fast"]["weight"] = 1;
    var_1["teleport"]["weight"] = 2;
    var_1["exploder"]["weight"] = 1;
  } else if(var_0 == 8) {
    var_1["emz"]["weight"] = 6;
    var_1["fast"]["weight"] = 1;
    var_1["teleport"]["weight"] = 3;
    var_1["exploder"]["weight"] = 1;
    var_1["armor"]["weight"] = 1;
  } else if(var_0 <= 19) {
    var_1["emz"]["weight"] = 8;
    var_1["fast"]["weight"] = 1;
    var_1["teleport"]["weight"] = 4;
    var_1["exploder"]["weight"] = 1;
    var_1["armor"]["weight"] = 1;
    var_1["spiked"]["weight"] = 1;
  } else if(var_0 >= 20) {
    var_1["emz"]["weight"] = 12;
    var_1["teleport"]["weight"] = 3;
    var_1["exploder"]["weight"] = 1;
    var_1["armor"]["weight"] = 1;
    var_1["spiked"]["weight"] = 1;
  }

  return var_1;
}

zombiearkrunzomboniachievementforplayer() {
  self endon("disconnect");
  level endon("game_ended");
  self.zomboniridetime = 0;
  var_0 = 0.1;
  var_1 = 300.0;

  for(;;) {
    wait(var_0);

    if(!isalive(self) || maps\mp\zombies\_util::isplayerinlaststand(self)) {
      continue;
    }
    if(self.sessionstate == "spectator" || self.sessionstate == "intermission") {
      continue;
    }
    var_2 = self getgroundentity();

    if(isDefined(var_2)) {
      var_3 = var_2 getlinkedparent();

      if(isDefined(var_3) && isDefined(var_3.iszomboni) && var_3.iszomboni) {
        self.zomboniridetime = self.zomboniridetime + var_0;
        var_4 = 0;

        if(self.zomboniridetime >= var_1 && !var_4) {
          maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_ZOMBONI");
          return;
        }
      }
    }
  }
}

zombiearkrunachievementsforplayer() {
  thread zombiearkrunzomboniachievementforplayer();
}

zombiearkrunsharktrigger(var_0, var_1) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_2);

    if(maps\mp\zombies\_util::is_true(var_2.jumpedtheshark)) {
      continue;
    }
    if(!var_2 isjumping() && !var_2 ishighjumping()) {
      continue;
    }
    if(var_1 && !maps\mp\zombies\_util::is_true(level.zmbsharktriggeractive)) {
      continue;
    }
    if(!isDefined(var_2.sharktriggertimes)) {
      var_2.sharktriggertimes = [];

      for(var_3 = 0; var_3 < level.numsharktriggers; var_3++) {
        var_2.sharktriggertimes[var_2.sharktriggertimes.size] = 0;
      }
    }

    var_4 = gettime();
    var_2.sharktriggertimes[var_0] = var_4;
    var_5 = var_4;

    for(var_3 = 0; var_3 < var_2.sharktriggertimes.size; var_3++) {
      if(var_2.sharktriggertimes[var_3] < var_5) {
        var_5 = var_2.sharktriggertimes[var_3];
      }
    }

    var_6 = 0;
    var_9 = 10000;

    if(var_5 > 0 && var_4 - var_5 < var_9 && !var_6) {
      var_2 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_JUMPTHESHARK");
      var_2.jumpedtheshark = 1;
    }
  }
}

zombiearkrunsharkachievement() {
  var_0 = getEntArray("shark_trigger_static", "targetname");
  var_1 = getEntArray("shark_trigger_dynamic", "targetname");
  var_2 = 0;
  level.numsharktriggers = var_0.size + var_1.size;

  foreach(var_4 in var_0) {
    var_4 thread zombiearkrunsharktrigger(var_2, 0);
    var_2++;
  }

  foreach(var_4 in var_1) {
    var_4 thread zombiearkrunsharktrigger(var_2, 1);
    var_2++;
  }
}

zombiearkrunachievements() {
  level endon("game_ended");
  level thread zombiearkrunsharkachievement();

  foreach(var_1 in level.players) {
    var_1 thread zombiearkrunachievementsforplayer();
  }

  for(;;) {
    level waittill("connected", var_1);
    var_1 thread zombiearkrunachievementsforplayer();
  }
}

zombiearkrunboatsway() {
  level endon("game_ended");

  for(;;) {
    var_0 = randomfloatrange(0.25, 1);
    var_1 = randomfloatrange(3, 4);
    level.swayent rotateto((var_0, 0, 0), var_1, var_1 * 0.5, var_1 * 0.5);
    wait(var_1);
    level.swayent rotateto((0 - var_0, 0, 0), var_1, var_1 * 0.5, var_1 * 0.5);
    wait(var_1);
  }
}

zombiearkapplyswayentforconditions() {
  if(maps\mp\zombies\_util::is_true(self.intoxicated)) {
    return;
  }
  if(maps\mp\zombies\_util::is_true(self.onisland)) {
    self playersetgroundreferenceent(undefined);
  } else if(maps\mp\zombies\_util::is_true(self.boatswaydisabled)) {
    self playersetgroundreferenceent(undefined);
  } else {
    self playersetgroundreferenceent(level.swayent);
  }
}

zombiearksetswayrefent() {
  self endon("disconnect");
  level endon("game_ended");
  zombiearkapplyswayentforconditions();

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return_no_endon_death("spawned", "update_ground_ref_ent");

    if(var_0 == "spawned") {
      maps\mp\zombies\_util::waittillplayersnextsnapshot(self);
    }

    zombiearkapplyswayentforconditions();
  }
}

zombiearkboatsway() {
  level endon("game_ended");
  level.swayent = spawn("script_model", (0, 0, 0));
  level thread zombiearkrunboatsway();

  foreach(var_1 in level.players) {
    var_1 thread zombiearksetswayrefent();
  }

  for(;;) {
    level waittill("connected", var_1);
    var_1 thread zombiearksetswayrefent();
  }
}

zombiearkstartgametypelevel() {
  level thread maps\mp\zombies\_teleport::init();
  level thread maps\mp\zombies\_gambling::init();
  level thread maps\mp\zombies\traps\_trap_turrets::init();
  level thread maps\mp\zombies\traps\_trap_water_floor::init();
  maps\mp\zombies\_traps::register_trap_state_models("dlc_trap_activation_console_01_no_signal", "dlc_trap_activation_console_01_ready", "dlc_trap_activation_console_01_active", "dlc_trap_activation_console_01_cooldown");
  level thread maps\mp\zombies\_util::outofboundswatch(0);
  level thread zombiearkrunachievements();
  level thread zombiearkboatsway();
}

calculatespecialroundtype() {
  return maps\mp\gametypes\zombies::calculatespecialroundtype();
}

zombiearkchoosespawncharacters() {
  var_0 = [0, 1];
  var_0 = common_scripts\utility::array_randomize(var_0);
  var_1 = [2, 3];
  var_1 = common_scripts\utility::array_randomize(var_1);
  var_2 = [var_0, var_1];
  var_2 = common_scripts\utility::array_randomize(var_2);
  level.spawncharindexforplayerindex = [];
  level.spawncharindexforplayerindex[0] = var_2[0][0];
  level.spawncharindexforplayerindex[1] = var_2[0][1];
  level.spawncharindexforplayerindex[2] = var_2[1][0];
  level.spawncharindexforplayerindex[3] = var_2[1][1];
  level.spawnzoneforplayerindex = [];

  if(common_scripts\utility::cointoss()) {
    level.spawnzoneforplayerindex[0] = "sidebay";
    level.spawnzoneforplayerindex[1] = "sidebay";
    level.spawnzoneforplayerindex[2] = "rearbay";
    level.spawnzoneforplayerindex[3] = "rearbay";
  } else {
    level.spawnzoneforplayerindex[0] = "rearbay";
    level.spawnzoneforplayerindex[1] = "rearbay";
    level.spawnzoneforplayerindex[2] = "sidebay";
    level.spawnzoneforplayerindex[3] = "sidebay";
  }
}

zombiearkassignzombieclientid() {
  if(!isDefined(level.arkconnectedplayers)) {
    level.arkconnectedplayers = [];
  }

  level.arkconnectedplayers = common_scripts\utility::array_removeundefined(level.arkconnectedplayers);
  level.arkconnectedplayers[level.arkconnectedplayers.size] = self;

  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = 0;

    foreach(var_3 in level.arkconnectedplayers) {
      if(!isDefined(var_3) || isremovedentity(var_3) || var_3 == self) {
        continue;
      }
      if(isDefined(var_3.zombieclientid) && var_3.zombieclientid == var_0) {
        var_1 = 1;
        break;
      }
    }

    if(!var_1) {
      self.zombieclientid = var_0;
      return;
    }
  }
}

zombiearkgivecustomcharacter(var_0) {
  zombiearkassignzombieclientid();
  var_1 = self.zombieclientid;
  var_1 = int(clamp(var_1, 0, 3));

  if(!isDefined(level.spawncharindexforplayerindex)) {
    zombiearkchoosespawncharacters();
  }

  if(isDefined(var_0)) {
    self.characterindex = var_0;
  } else {
    self.characterindex = level.spawncharindexforplayerindex[var_1];
  }

  var_3 = 1;

  if(self.characterindex == -1) {
    var_3 = 0;
    self.characterindex = 0;
  }

  if(var_3) {
    var_2 = "ui_zm_character_" + self.characterindex;
    setomnvar(var_2, self getentitynumber());
    var_4 = "ui_zm_character_" + self.characterindex + "_alive";
    setomnvar(var_4, 0);
    thread maps\mp\zombies\_util::resetcharacterondisconnect(var_2, var_4, self.characterindex);
  }

  maps\mp\zombies\_util::setcustomcharacter(self.characterindex, 0);
  maps\mp\zombies\_util::setcharacteraudio(self.characterindex);
}

zombiearkfilterstartspawns(var_0) {
  if(!isPlayer(self)) {
    return var_0;
  }

  var_1 = self.zombieclientid;
  var_1 = int(clamp(var_1, 0, 3));
  var_2 = level.spawnzoneforplayerindex[var_1];
  var_3 = [];

  foreach(var_5 in var_0) {
    if(!isDefined(var_5.script_noteworthy) || var_5.script_noteworthy == var_2) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

zombiearkfilterrespawns(var_0) {
  if(!isPlayer(self)) {
    return var_0;
  }

  var_1 = self.zombieclientid;
  var_1 = int(clamp(var_1, 0, 3));
  var_2 = level.spawnzoneforplayerindex[var_1];
  var_3 = [];

  foreach(var_5 in var_0) {
    if(!isDefined(var_5.script_noteworthy) || maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_5.script_noteworthy) && maps\mp\zombies\_zombies_zone_manager::getzoneconnectionlength(var_5.script_noteworthy, var_2) >= 0) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

zmbteleportgrenadefindzonecustom(var_0, var_1, var_2) {
  var_3 = getent("zomboni_room_volume", "targetname");

  if(isDefined(var_3) && ispointinvolume(var_2, var_3)) {
    return "cargo_bay";
  }
}

zmteleporterinit(var_0, var_1) {
  switch (var_1) {
    case "ark_device":
      thread teleporter_device(var_0);
      break;
    case "ark_light":
      thread teleporter_light(var_0);
      break;
    default:
      return 0;
  }

  return 1;
}

zmteleporterused(var_0) {
  if(isDefined(self.device)) {
    playFXOnTag(common_scripts\utility::getfx("dlc_teleport_in"), self.device, "tag_fx");
    wait 0.3;
  }
}

zmteleporterroomenter(var_0, var_1) {
  common_scripts\utility::array_thread(var_0, ::teleporterfx);
}

teleporterfx() {
  if(!isDefined(self.teleportchutefx)) {
    self.teleportchutefx = spawnfxforclient(common_scripts\utility::getfx("dlc_teleport_tunnel_player"), self.origin, self);
    self.teleportchutefx thread teleportfxdelete(self);
  }

  triggerfx(self.teleportchutefx);
}

teleportfxdelete(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self delete();
}

zmteleporterplayers(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    playFX(common_scripts\utility::getfx("teleport_post_fx"), var_2.origin, anglesToForward(var_2.angles));
  }
}

teleporter_device(var_0) {
  self.device = var_0;
  var_0 hidepart("TAG_FX_ON");
  var_0 hidepart("TAG_FX_OFF");
  var_0 showpart("TAG_FX_GLOW");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"), var_0, "tag_origin", 0);
  self waittill("teleportReady");
  var_0 showpart("TAG_FX_ON");
  var_0 hidepart("TAG_FX_OFF");
  var_0 hidepart("TAG_FX_GLOW");
  var_0 playLoopSound("teleporter_hum");
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"), var_0, "tag_origin");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"), var_0, "tag_origin", 0);
}

teleporter_light(var_0) {
  var_0 setlightcolor((0.941176, 0, 0));
  var_0 setlightintensity(250);
  self waittill("teleportReady");
  var_0 setlightcolor((0.501961, 1, 1));
  var_0 setlightintensity(3500);
}

getteleporterlightcoloron() {
  return (0.501961, 1, 1);
}

getteleporterlightcolorstandby() {
  return (0.941176, 0, 0);
}

getteleporterlightcoloroff() {
  return (0.941176, 0, 0);
}

getteleporterlightintensityon() {
  return 3500;
}

getteleporterlightintensitystandby() {
  return 250;
}

getteleporterlightintensityoff() {
  return 0.001;
}

doidlesharkanimations() {
  var_0 = getEntArray("shark_animated", "targetname");

  foreach(var_2 in var_0) {
    var_2 scriptmodelplayanim("zom_ark_shark_cage_idle", "shark_notetrack");
    var_2 thread maps\mp\mp_zombie_ark_aud::idle_shark_sound();
    wait 2;
  }
}

killglass() {
  while(!isDefined(level.players)) {
    wait 0.05;
  }

  var_0 = [];

  for(var_1 = 0; var_1 <= 1; var_1++) {
    var_2 = getglass("ark_glass_" + var_1);
    var_3 = getent("ark_glass_trigger_" + var_1, "targetname");

    if(isDefined(var_2) && isDefined(var_3)) {
      var_0[var_1] = [var_2, var_3];
    }
  }

  for(;;) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_4 = var_0[var_1];

      if(isglassdestroyed(var_4[0])) {
        var_0[var_1] = var_0[var_0.size - 1];
        var_0[var_0.size - 1] = undefined;
        var_1--;
      }
    }

    if(var_0.size == 0) {
      return;
    }
    foreach(var_6 in level.players) {
      if(!isalive(var_6) || var_6.sessionstate == "spectator" || var_6.sessionstate == "intermission") {
        continue;
      }
      if(maps\mp\zombies\_util::is_true(var_6.validnotmoving)) {
        foreach(var_4 in var_0) {
          if(var_6 istouching(var_4[1])) {
            destroyglass(var_4[0]);
          }
        }
      }
    }

    wait 1.0;
  }
}

agentshouldragdollimmediately(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return isDefined(var_4) && (var_4 == "repulsor_zombie_mp" || var_4 == "zombie_water_trap_mp");
}

flyoverbink() {
  var_0 = "zombie_bink_env_camera_DLC3";
  var_1 = "scr_" + var_0;
  setDvar(var_1, 0);
  var_2 = "devgui_cmd \"Zombie:2/Toggle Flyover Binks/" + var_0 + "\" \"togglep " + var_1 + " 0 1\";";
  thread setupflyoveranimation("zombie_bink_env_camera_DLC3", "j_prop_1", ["open_doors", "trigger_decontamination"], var_1);
}

setupflyoveranimation(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct("shark_anim_node", "targetname");

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_4.angles)) {
    var_4.angles = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  }

  while(getdvarint(var_3, 0) == 0) {
    waitframe();
  }

  setDvar("lui_enabled", 0);
  setDvar("cg_drawBuildname", 0);
  setDvar("cg_drawMapBuildInfo", 0);
  setDvar("cg_drawversion", 0);
  setDvar("cg_drawviewpos", 0);
  setDvar("cg_fovScale", 1.1);
  level.zombiegamepaused = 1;
  var_5 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_7 in var_5) {
    var_7.bypasscorpse = 1;
    var_7 dodamage(var_7.health + 500000, var_7.origin, level.players[0], undefined, "MOD_EXPLOSIVE", "repulsor_zombie_mp");
  }

  wait 2;
  var_9 = spawn("script_model", (0, 0, 0));
  var_9 setModel("genericprop_x3");
  var_10 = spawn("script_model", (0, 0, 0));
  var_10 setModel("tag_player");
  var_10 linktosynchronizedparent(var_9, var_1, (0, 0, 0), (0, 0, 0));

  for(;;) {
    while(getdvarint(var_3, 0) == 0) {
      waitframe();
    }

    level.player playerlinkweaponviewtodelta(var_10, "tag_player", 1, 0, 0, 0, 0, 1);
    level.player playerlinkedsetviewznear(0);
    level.player hide();
    var_9 scriptmodelplayanimdeltamotionfrompos(var_0, var_4.origin, var_4.angles, "camera_notetrack");

    foreach(var_12 in var_2) {
      level thread donotetrack(var_9, "camera_notetrack", var_12);
    }

    wait 1;

    while(getdvarint(var_3, 0) == 1) {
      waitframe();
    }

    var_9 notify("notetrackDone");
    level.player show();
    level.player unlink();
    var_9 scriptmodelclearanim();
    wait 1;
  }
}

donotetrack(var_0, var_1, var_2, var_3) {
  var_0 endon("notetrackDone");
  var_0 waittillmatch(var_1, var_2);

  if(var_2 == "trigger_decontamination") {
    var_4 = getEntArray("perk_terminal", "targetname");

    foreach(var_6 in var_4) {
      if(var_6.trigger.itemtype == "host_cure") {
        var_6.trigger thread maps\mp\zombies\_terminals::perkterminalactivatehostcure(5);
      }
    }
  } else if(var_2 == "open_doors") {
    foreach(var_9 in level.zombiedoors) {
      var_9 notify("open", level.player);
    }
  }

  level notify(var_2);
}

setupscriptmodelanimation(var_0, var_1, var_2, var_3, var_4) {
  var_5 = common_scripts\utility::getstruct("env_bink_anim_node", "targetname");

  if(!isDefined(var_5)) {
    var_5 = spawnStruct();
    var_5.origin = (0, 3584, 88);
  }

  if(!isDefined(var_5.angles)) {
    var_5.angles = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = [];
  }

  var_6 = spawn("script_model", (0, 0, 0));
  var_6 setModel(var_1);

  for(;;) {
    while(getdvarint(var_4, 0) == 0) {
      waitframe();
    }

    if(isDefined(var_2)) {
      level waittill(var_2);
    }

    var_6 scriptmodelplayanimdeltamotionfrompos(var_0, var_5.origin, var_5.angles, "ent_notetrack");

    foreach(var_8 in var_3) {
      level thread donotetrack(var_6, "ent_notetrack", var_8);
    }

    wait 1;

    while(getdvarint(var_4, 0) == 1) {
      waitframe();
    }

    var_6 notify("notetrackDone");
    var_6 scriptmodelclearanim();
    wait 1;
  }
}

exoreveal() {
  level waittill("power_cargo_01");

  foreach(var_1 in level.terminals["exo_suit"]) {
    if(maps\mp\zombies\_util::isusetriggerprimary(var_1)) {
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("exo_reveal"), var_1.modelent, "tag_origin");
    }
  }
}

spawnpatchclipfixes() {
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (68, -773, 1088), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (68, -773, 1344), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (-1168, -1898, 1456), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (-1168, -1874, 1456), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (-1168, -1852, 1456), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (-1168, -1178, 1456), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (-1168, -1154, 1456), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (-1168, -1132, 1456), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (-1634.5, 1281, 928), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128", (-1891, 1075, 824), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128", (-1891, 1075, 867), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (-924, 338, 1267.5), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (-924, 338, 1203.5), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (-924, 338, 1159.5), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (264, 2532, 961), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (264, 2526, 961), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (264, 2532, 1025), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (264, 2526, 1025), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (264, 2532, 1089), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (264, 2526, 1089), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (264, 2532, 1147), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (264, 2526, 1147), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (1434, -74.5, 864), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (1434, -94.5, 864), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (1434, -74.5, 928), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (1434, -94.5, 928), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (1434, -74.5, 992), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (1434, -94.5, 992), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (1434, -74.5, 1056), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (1434, -94.5, 1056), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (1088, 768, 848), (0, 225, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (1088, 64, 848), (0, 315, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (316, 619, 1030), (360, 228.599, 46.1996));
}

zombiearkpatchshove(var_0, var_1) {
  if(var_1) {
    if(self.currentzone == "sidebay") {
      if(self.origin[2] >= 1010 && self.origin[2] <= 1012) {
        if(self.origin[0] >= -1670 && self.origin[0] <= -1625 && self.origin[1] >= -693 && self.origin[1] <= -446) {
          self setvelocity((200, 0, 0));
        }
      }

      if(self.origin[2] >= 1073 && self.origin[2] <= 1075) {
        if(self.origin[0] >= -1080 && self.origin[0] <= -970 && self.origin[1] >= -1985 && self.origin[1] <= -1975) {
          self setvelocity((0, -200, 0));
        }
      }

      if(distancesquared(self.origin, (-1136, -1982, 1095)) < 144) {
        self setvelocity((0, -200, 0));
      }
    } else if(self.currentzone == "armory") {
      if(distancesquared(self.origin, (-1036, 1057, 1127)) < 144) {
        var_2 = self getnearestnode();

        if(isDefined(var_2) && abs(var_2.origin[2] - self.origin[2]) > 120) {
          var_3 = vectornormalize((var_2.origin - self.origin) * (1, 1, 0));
          self setvelocity(var_3 * 100);
        }
      }
    } else if(self.currentzone == "rearbay") {
      if(distancesquared(self.origin, (-757, -1167, 879)) < 144) {
        self setvelocity((-200, 0, 0));
      }

      if(distancesquared(self.origin, (-867, -2016, 1120)) < 144) {
        self setvelocity((200, 0, 0));
      }
    }
  }
}