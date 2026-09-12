/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58253.gsc
***********************************************/

function subscribetoquestlocale() {
  init_vfx();
  init_dvars();
}

function init_vfx() {
  level._effect["vfx_br_decontamination_station_circle_blue"] = loadfx("vfx/iw8/prop/scriptables/vfx_br_decontamination_station_circle_blue");
  level._effect["vfx_br_decontamination_station_circle_steam"] = loadfx("vfx/iw8_br/island/equip/decon/vfx_br3_decon_steam");
  level._effect["vfx_br_decontamination_station_circle_aura"] = loadfx("vfx/iw8_br/island/equip/decon/vfx_br3_decon_aura");
  level._effect["vfx_decon_station_screen_fx"] = loadfx("vfx/iw8_br/island/equip/decon/vfx_br3_decon_scrnfx");
}

function init_dvars() {
  if(!isDefined(level.iswztrain)) {
    level.iswztrain = spawnStruct();
    level.iswztrain.instances = [];
  }

  level.iswztrain.lifetime = getdvarfloat("scr_decon_station_lifetime", 20);
  level.iswztrain.weaponswitchhintlogic = getdvarfloat("scr_decon_station_lifetime_last_circle", -1);
  level.iswztrain.ref_142cd = getdvarfloat("scr_decon_station_visibility_delay", 0.1);
  level.iswztrain.infinite_ammo = getdvarint("scr_decon_station_infinite_ammo", 0);
}

function jugg_protect_jammer() {
  self.jugg_pursue_target = undefined;
  var_0 = scripts\mp\equipment::getequipmentmaxammo("equip_decon_station");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    javelin_interact_monitor();
  }
}

function javelin_interact_monitor(var_0) {
  if(!isDefined(self.jugg_pursue_target)) {
    self.jugg_pursue_target = [];
  }

  if(self.jugg_pursue_target.size < jug_trig_spawn()) {
    if(!isDefined(var_0)) {
      var_0 = 3;
    }

    self.jugg_pursue_target[self.jugg_pursue_target.size] = var_0;
    return;
  }
}

function jugg_modifyherodroptoplayerdamage() {
  if(isDefined(self.jugg_pursue_target) && self.jugg_pursue_target.size > 0) {
    var_0 = self.jugg_pursue_target[self.jugg_pursue_target.size - 1];
    self.jugg_pursue_target[self.jugg_pursue_target.size - 1] = undefined;
    return var_0;
  }

  return undefined;
}

function jugg_modifyfalldamage() {
  self.jugg_pursue_target = undefined;
}

function jugg_go_to_node_callback(var_0, var_1) {
  jugg_modifyfalldamage();
}

function jugg_getminigunweapon(var_0, var_1) {
  jugg_protect_jammer();
}

function jug_trig_spawn() {
  return scripts\mp\equipment::getequipmentmaxammo("equip_decon_station");
}

function jug_reinforce() {
  jug_encounter_test(undefined, 0, 0.15);
}

function jugg_dmg_debug() {
  jug_encounter_test(undefined, 0, 0.15);
}

function jeep_initomnvars(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  var_0.owner = self;
  var_0 setotherent(var_0.owner);
  var_0 setnodeploy(1);
  var_0.issuper = isDefined(var_0.owner.super) && var_0.owner.super.staticdata.weapon == "decon_station_mp";
  var_0.superid = level.superglobals.staticsuperdata["super_decon_station"].id;
  var_0.usedcount = 0;
  var_0 scripts\cp_mp\ent_manager::registerspawn(2, &jug_reinforce);
  thread jeep_initcollision();
  thread jeep(var_0);
  var_0 waittill("missile_stuck", var_1);
  var_0.owner thread scripts\mp\weapons::monitordisownedgrenade(var_0.owner, var_0);
  scripts\mp\utility\print::printgameaction("trophy spawned", self);

  if(!istrue(var_0.issuper)) {
    var_0.ammo = jugg_modifyherodroptoplayerdamage();

    if(!isDefined(var_0.ammo)) {
      var_0.ammo = 3;
    }

    var_0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  } else {
    var_0.ammo = 3;
  }

  var_0.owner scripts\mp\weapons::onequipmentplanted(var_0, "equip_decon_station", &jugg_dmg_debug);
  var_0 thread scripts\mp\weapons::monitordisownedequipment(var_0.owner, var_0);
  var_0 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", var_0.owner);
  var_0.explosion = jeep_horn();
  var_2 = var_0.owner scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");

  if(var_2) {
    var_0.hasruggedeqp = 1;
  }

  var_3 = scripts\engine\utility::ter_op(var_2, 200, 100);
  var_4 = "hitequip";
  var_0 thread scripts\mp\damage::monitordamage(var_3, var_4, &jugg_canreload, &jugg_canparachute, 0);
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&jugg_assault3_check_size);
  var_0 setscriptablepartstate("visibility", "show", 0);
  thread javelin_forceclear();
}

function javelin_forceclear() {
  self endon("death");
  self setscriptablepartstate("effects", "activeLand");

  if(level.gametype == "br") {
    self.ignoreme = 1;
  }

  wait 0.1;
  thread joininprogresstimeout();
  thread jugg_pursue_players(1);
  wait 0.4;
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  self.ref_13b97 = gettime();
  self.ref_13b96 = gettime() + level.iswztrain.lifetime * 1000;
  level.iswztrain.instances = scripts\engine\utility::array_add(level.iswztrain.instances, self);
  var_0 = self.origin - (0, 0, 125);
  var_1 = 20;
  var_2 = var_0 + (0, 0, var_1);
  var_3 = spawn("trigger_radius", var_2, 0, 250, 250);
  scripts\mp\utility\trigger::makeenterexittrigger(var_3, &jugg_combo, &jugg_enter_combat_callback, undefined, undefined, &jugg_get_priority_player);
  var_3.tracknonoobplayerlocation = self;
  var_3 enablelinkTo();
  var_3 linkTo(self);
  self.trigger = var_3;
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(3, 0, 1, self.origin);
  scripts\mp\gametypes\br_quest_util::ref_13369();
  scripts\mp\gametypes\br_quest_util::ref_1316f(250);
  var_4 = level.iswztrain.lifetime;

  if(isDefined(level.br_circle) && scripts\mp\gametypes\br_circle::islastcircle() && level.iswztrain.weaponswitchhintlogic > 0) {
    var_4 = level.iswztrain.weaponswitchhintlogic;
  }

  wait var_4;
  jug_encounter_test(undefined, 0, 0.15);
  jugg_canuseweaponpickups();
  thread scripts\mp\equipment_interact::remoteinteractsetup(&jug_encounter_test, 1, 1);
  thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

function jugg_idle_until_shot_or_near(var_0) {
  self.start_death_from_above_sequence = 1;
  thread jugg_modifyvehicletoplayerdamage();
  var_1 = int((var_0.ref_13b96 - gettime()) / 1000);
}

function jugg_managestockammo() {
  self.start_death_from_above_sequence = 0;
  jugg_objective_struct();
}

function jugg_disableoverlayonentergulag() {
  if(!isDefined(self.gastriggerstouching)) {
    self.gastriggerstouching = [];
  }

  if(self.gastriggerstouching.size > 0) {
    foreach(var_1 in self.gastriggerstouching) {
      if(!isDefined(var_1)) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_1.playersintrigger, self)) {
        scripts\mp\equipment\gas_grenade::gas_onexittrigger(var_1 getentitynumber());
        return true;
      }
    }
  }

  return false;
}

function jugg_get_closest_attackable_player() {
  if(!isDefined(self.gastriggerstouching)) {
    self.gastriggerstouching = [];
  }

  if(self.gastriggerstouching.size > 0) {
    foreach(var_1 in self.gastriggerstouching) {
      if(!isDefined(var_1)) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_1.playersintrigger, self)) {
        scripts\mp\equipment\gas_grenade::gas_onentertrigger(var_1);
        return true;
      }
    }
  }

  return false;
}

function jugg_combo(var_0, var_1) {
  var_2 = gettime() + 500 >= var_1.tracknonoobplayerlocation.ref_13b96;

  if(!var_2 && jugg_addtoactivejugglist(var_0) && !istrue(var_1.tracknonoobplayerlocation.ref_122f2)) {
    var_3 = var_0;
    var_3.start_death_from_above_sequence = 1;
    jugg_idle_until_shot_or_near(var_3, var_1.tracknonoobplayerlocation);
    jugg_disableoverlayonentergulag(var_3);
    jugg_maze_killtrigger(var_1.tracknonoobplayerlocation, var_3);

    if(scripts\cp_mp\gasmask::hasgasmask(var_3)) {
      var_3 scripts\mp\gametypes\br_pickups::plunderrankupdate("br_circle");
      var_3 scripts\mp\gametypes\br_pickups::plunderrankupdate("city_killer");
      var_3 scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_factory_gas");
    }

    if(isPlayer(var_3)) {
      var_3 scripts\mp\equipment\gas_grenade::gas_clear(0);
      return;
    }

    return;
  }
}

function jugg_enter_combat_callback(var_0, var_1) {
  if(jugg_addtoactivejugglist(var_0)) {
    var_2 = var_0;
    jugg_managestockammo(var_2);
    jugg_get_closest_attackable_player(var_2);
    return;
  }
}

function jugg_get_priority_player(var_0, var_1) {
  if(jugg_addtoactivejugglist(var_0) || isDefined(var_0.vehicletype)) {
    return false;
  }

  return true;
}

function jugg_maze_killtrigger(var_0) {
  if(!isDefined(self.trigger.participants)) {
    self.trigger.participants = [];
  }

  if(scripts\engine\utility::array_contains(self.trigger.participants, var_0)) {
    return;
  }

  self.trigger.participants = scripts\engine\utility::array_add(self.trigger.participants, var_0);
}

function jugg_addtoactivejugglist(var_0) {
  return isPlayer(var_0) || isagent(var_0) || isbot(var_0);
}

function jugg_pursue_players(var_0) {
  var_1 = "j_body";

  if(var_0) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_aura"), self, var_1);
  } else {
    killfxontag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_aura"), self, var_1);
  }

  for(var_2 = 1; var_2 <= 3; var_2++) {
    var_3 = "tag_fx";

    if(var_2 > 1) {
      var_3 += scripts\engine\utility::string(var_2);
    }

    playFXOnTag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_steam"), self, var_3);
  }
}

function jugg_protect_jammer_internal() {
  killfxontag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_aura"), self, "j_body");

  for(var_0 = 1; var_0 <= 3; var_0++) {
    var_1 = "tag_fx";

    if(var_0 > 1) {
      var_1 += scripts\engine\utility::string(var_0);
    }

    stopFXOnTag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_steam"), self, var_1);
  }
}

function joininprogresstimeout() {
  self endon("death");
  self setscriptablepartstate("effects", "activeDeployStart");
  wait jug_spawn_func();
  self setscriptablepartstate("effects", "activeDeployEnd");
}

#using_animtree("scriptables");

function jug_spawn_func() {
  return getanimlength(%wm_trophy_system_deploy_landing);
}

function jugg_assault3_check_size(var_0) {
  var_1 = var_0.victim;
  jug_trigger_spawn(var_1, var_0.attacker);
  jugg_canuseweaponpickups(var_1);
  thread jug_encounter_test(var_1, var_0.attacker);
}

function jugg_modifyvehicletoplayerdamage() {
  if(isagent(self)) {
    return;
  }

  if(istrue(self.isx1ops)) {
    return;
  }

  self.isx1ops = 1;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_decon_station_screen_fx"), self, "j_head");
  waitframe();
  var_0 = playfxontagforclients(scripts\engine\utility::getfx("vfx_decon_station_screen_fx"), self, "j_head", self);
}

function jugg_objective_struct(var_0) {
  if(isagent(self)) {
    return;
  }

  if(istrue(var_0)) {
    killfxontag(scripts\engine\utility::getfx("vfx_decon_station_screen_fx"), self, "j_head");
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_decon_station_screen_fx"), self, "j_head");
  self.isx1ops = 0;
}

function jugg_canparachute(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_4;
  var_5 = scripts\mp\damage::handlemeleedamage(var_2, var_3, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_2, var_3, var_5);
  scripts\mp\weapons::equipmenthit(self.owner, var_1, var_2, var_3);
  return var_5;
}

function jugg_canuseweaponpickups() {
  if(isDefined(self.trigger)) {
    if(!isDefined(self.trigger.participants)) {
      self.trigger.participants = [];
    }

    var_0 = scripts\engine\utility::array_combine_unique(self.trigger.triggerenterents, self.trigger.participants);

    foreach(var_2 in var_0) {
      jugg_enter_combat_callback(var_2, var_2, self.trigger);
    }
  }

  jugg_protect_jammer_internal();
  level.iswztrain.instances = scripts\engine\utility::array_remove(level.iswztrain.instances, self);

  if(isDefined(self.mapcircle)) {
    scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  }

  waitframe();

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self notify("disperse");
}

function jugg_canreload(var_0) {
  var_1 = var_0.attacker;
  jug_trigger_spawn(var_1);
  thread jug_encounter_test(var_1, 1);
}

function jug_encounter_test(var_0, var_1, var_2) {
  level endon("game_ended");
  thread jeep_initdamage(var_0, var_1);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);
  self.ref_122f2 = 1;

  if(!isDefined(var_2)) {
    var_2 = 0.15;
  }

  wait var_2;

  if(isDefined(self.explosion)) {
    self.explosion delete();
  }

  if(isDefined(self)) {
    self setscriptablepartstate("effects", "activeDestroyEnd", 0);
    return;
  }
}

function jeep_initdamage(var_0, var_1) {
  level endon("game_ended");
  self notify("disperse");
  self notify("death");
  self setscriptablepartstate("hack_usable", "off");
  self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_trophy", self.usedcount, var_0, var_1);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var_1));
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    scripts\mp\weapons::makeexplosiveunusuabletag();
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.owner)) {
    self.owner notify("trophy_update", 0);
    self.owner scripts\mp\weapons::removeequip(self);
  }

  jugg_canuseweaponpickups();
  self setscriptablepartstate("anims", "neutral", 0);
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
  wait 2;
  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function jug_trigger_spawn(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    var_0 thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    return;
  }
}

function jeep_horn() {
  var_0 = spawn("script_model", self.origin);
  var_0.killcament = self;
  var_0.owner = self.owner;
  var_0.team = self.team;
  var_0.equipmentref = self.equipmentref;
  var_0.weapon_name = self.weapon_name;
  var_0 setotherent(var_0.owner);
  var_0 setentityowner(var_0.owner);
  var_0 setModel("trophy_system_mp_explode");
  var_0.explode1available = 1;
  return var_0;
}

function jeep_initcollision() {
  self endon("death");
  self endon("missile_stuck");
  var_0 = getdvarfloat("scr_trophy_proj_hide_duration", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait var_0;
  self setscriptablepartstate("visibility", "show", 0);
}

function jeep(var_0) {
  self endon("death");
  self endon("missile_stuck");
  var_0 endon("disconnect");
  var_1 = scripts\engine\utility::ref_143b9(2, "touching_platform");

  if(var_1 == "timeout") {
    return;
  }

  var_2 = undefined;
  var_3 = tablesort(self.origin, 500, 500);
  GscBinSkip0(0x2e, var_3.size, self);
}

function tugofwar_tank(var_0) {
  if(isDefined(level.ref_145f1)) {
    foreach(var_2 in level.ref_145f1.ref_13c8d) {
      if(var_2 == var_0) {
        return true;
      }

      if(isDefined(var_2.wz_tease) && var_2.wz_tease == var_0) {
        return true;
      }
    }
  }

  return false;
}

function jugg_health_debug() {
  if(self.owner scripts\mp\equipment::hasequipment("equip_decon_station")) {
    javelin_interact_monitor(self.owner, self.ammo);
    return;
  }
}