/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58253.gsc
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
  var0 = scripts\mp\equipment::getequipmentmaxammo("equip_decon_station");

  for(var1 = 0; var1 < var0; var1++) {
    javelin_interact_monitor();
  }
}

function javelin_interact_monitor(var0) {
  if(!isDefined(self.jugg_pursue_target)) {
    self.jugg_pursue_target = [];
  }

  if(self.jugg_pursue_target.size < jug_trig_spawn()) {
    if(!isDefined(var0)) {
      var0 = 3;
    }

    self.jugg_pursue_target[self.jugg_pursue_target.size] = var0;
    return;
  }
}

function jugg_modifyherodroptoplayerdamage() {
  if(isDefined(self.jugg_pursue_target) && self.jugg_pursue_target.size > 0) {
    var0 = self.jugg_pursue_target[self.jugg_pursue_target.size - 1];
    self.jugg_pursue_target[self.jugg_pursue_target.size - 1] = undefined;
    return var0;
  }

  return undefined;
}

function jugg_modifyfalldamage() {
  self.jugg_pursue_target = undefined;
}

function jugg_go_to_node_callback(var0, var1) {
  jugg_modifyfalldamage();
}

function jugg_getminigunweapon(var0, var1) {
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

function jeep_initomnvars(var0) {
  var0 endon("death");
  self endon("disconnect");
  var0.owner = self;
  var0 setotherent(var0.owner);
  var0 setnodeploy(1);
  var0.issuper = isDefined(var0.owner.super) && var0.owner.super.staticdata.weapon == "decon_station_mp";
  var0.superid = level.superglobals.staticsuperdata["super_decon_station"].id;
  var0.usedcount = 0;
  var0 scripts\cp_mp\ent_manager::registerspawn(2, &jug_reinforce);
  thread jeep_initcollision();
  thread jeep(var0);
  var0 waittill("missile_stuck", var1);
  var0.owner thread scripts\mp\weapons::monitordisownedgrenade(var0.owner, var0);
  scripts\mp\utility\print::printgameaction("trophy spawned", self);

  if(!istrue(var0.issuper)) {
    var0.ammo = jugg_modifyherodroptoplayerdamage();

    if(!isDefined(var0.ammo)) {
      var0.ammo = 3;
    }

    var0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  } else {
    var0.ammo = 3;
  }

  var0.owner scripts\mp\weapons::onequipmentplanted(var0, "equip_decon_station", &jugg_dmg_debug);
  var0 thread scripts\mp\weapons::monitordisownedequipment(var0.owner, var0);
  var0 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", var0.owner);
  var0.explosion = jeep_horn();
  var2 = var0.owner scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");

  if(var2) {
    var0.hasruggedeqp = 1;
  }

  var3 = scripts\engine\utility::ter_op(var2, 200, 100);
  var4 = "hitequip";
  var0 thread scripts\mp\damage::monitordamage(var3, var4, &jugg_canreload, &jugg_canparachute, 0);
  var0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&jugg_assault3_check_size);
  var0 setscriptablepartstate("visibility", "show", 0);
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
  var0 = self.origin - (0, 0, 125);
  var1 = 20;
  var2 = var0 + (0, 0, var1);
  var3 = spawn("trigger_radius", var2, 0, 250, 250);
  scripts\mp\utility\trigger::makeenterexittrigger(var3, &jugg_combo, &jugg_enter_combat_callback, undefined, undefined, &jugg_get_priority_player);
  var3.tracknonoobplayerlocation = self;
  var3 enablelinkTo();
  var3 linkTo(self);
  self.trigger = var3;
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(3, 0, 1, self.origin);
  scripts\mp\gametypes\br_quest_util::ref_13369();
  scripts\mp\gametypes\br_quest_util::ref_1316f(250);
  var4 = level.iswztrain.lifetime;

  if(isDefined(level.br_circle) && scripts\mp\gametypes\br_circle::islastcircle() && level.iswztrain.weaponswitchhintlogic > 0) {
    var4 = level.iswztrain.weaponswitchhintlogic;
  }

  wait var4;
  jug_encounter_test(undefined, 0, 0.15);
  jugg_canuseweaponpickups();
  thread scripts\mp\equipment_interact::remoteinteractsetup(&jug_encounter_test, 1, 1);
  thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

function jugg_idle_until_shot_or_near(var0) {
  self.start_death_from_above_sequence = 1;
  thread jugg_modifyvehicletoplayerdamage();
  var1 = int((var0.ref_13b96 - gettime()) / 1000);
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
    foreach(var1 in self.gastriggerstouching) {
      if(!isDefined(var1)) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var1.playersintrigger, self)) {
        scripts\mp\equipment\gas_grenade::gas_onexittrigger(var1 getentitynumber());
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
    foreach(var1 in self.gastriggerstouching) {
      if(!isDefined(var1)) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var1.playersintrigger, self)) {
        scripts\mp\equipment\gas_grenade::gas_onentertrigger(var1);
        return true;
      }
    }
  }

  return false;
}

function jugg_combo(var0, var1) {
  var2 = gettime() + 500 >= var1.tracknonoobplayerlocation.ref_13b96;

  if(!var2 && jugg_addtoactivejugglist(var0) && !istrue(var1.tracknonoobplayerlocation.ref_122f2)) {
    var3 = var0;
    var3.start_death_from_above_sequence = 1;
    jugg_idle_until_shot_or_near(var3, var1.tracknonoobplayerlocation);
    jugg_disableoverlayonentergulag(var3);
    jugg_maze_killtrigger(var1.tracknonoobplayerlocation, var3);

    if(scripts\cp_mp\gasmask::hasgasmask(var3)) {
      var3 scripts\mp\gametypes\br_pickups::plunderrankupdate("br_circle");
      var3 scripts\mp\gametypes\br_pickups::plunderrankupdate("city_killer");
      var3 scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_factory_gas");
    }

    if(isPlayer(var3)) {
      var3 scripts\mp\equipment\gas_grenade::gas_clear(0);
      return;
    }

    return;
  }
}

function jugg_enter_combat_callback(var0, var1) {
  if(jugg_addtoactivejugglist(var0)) {
    var2 = var0;
    jugg_managestockammo(var2);
    jugg_get_closest_attackable_player(var2);
    return;
  }
}

function jugg_get_priority_player(var0, var1) {
  if(jugg_addtoactivejugglist(var0) || isDefined(var0.vehicletype)) {
    return false;
  }

  return true;
}

function jugg_maze_killtrigger(var0) {
  if(!isDefined(self.trigger.participants)) {
    self.trigger.participants = [];
  }

  if(scripts\engine\utility::array_contains(self.trigger.participants, var0)) {
    return;
  }

  self.trigger.participants = scripts\engine\utility::array_add(self.trigger.participants, var0);
}

function jugg_addtoactivejugglist(var0) {
  return isPlayer(var0) || isagent(var0) || isbot(var0);
}

function jugg_pursue_players(var0) {
  var1 = "j_body";

  if(var0) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_aura"), self, var1);
  } else {
    killfxontag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_aura"), self, var1);
  }

  for(var2 = 1; var2 <= 3; var2++) {
    var3 = "tag_fx";

    if(var2 > 1) {
      var3 += scripts\engine\utility::string(var2);
    }

    playFXOnTag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_steam"), self, var3);
  }
}

function jugg_protect_jammer_internal() {
  killfxontag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_aura"), self, "j_body");

  for(var0 = 1; var0 <= 3; var0++) {
    var1 = "tag_fx";

    if(var0 > 1) {
      var1 += scripts\engine\utility::string(var0);
    }

    stopFXOnTag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_steam"), self, var1);
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

function jugg_assault3_check_size(var0) {
  var1 = var0.victim;
  jug_trigger_spawn(var1, var0.attacker);
  jugg_canuseweaponpickups(var1);
  thread jug_encounter_test(var1, var0.attacker);
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
  var0 = playfxontagforclients(scripts\engine\utility::getfx("vfx_decon_station_screen_fx"), self, "j_head", self);
}

function jugg_objective_struct(var0) {
  if(isagent(self)) {
    return;
  }

  if(istrue(var0)) {
    killfxontag(scripts\engine\utility::getfx("vfx_decon_station_screen_fx"), self, "j_head");
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_decon_station_screen_fx"), self, "j_head");
  self.isx1ops = 0;
}

function jugg_canparachute(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var4;
  var5 = scripts\mp\damage::handlemeleedamage(var2, var3, var5);
  var5 = scripts\mp\damage::handleapdamage(var2, var3, var5);
  scripts\mp\weapons::equipmenthit(self.owner, var1, var2, var3);
  return var5;
}

function jugg_canuseweaponpickups() {
  if(isDefined(self.trigger)) {
    if(!isDefined(self.trigger.participants)) {
      self.trigger.participants = [];
    }

    var0 = scripts\engine\utility::array_combine_unique(self.trigger.triggerenterents, self.trigger.participants);

    foreach(var2 in var0) {
      jugg_enter_combat_callback(var2, var2, self.trigger);
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

function jugg_canreload(var0) {
  var1 = var0.attacker;
  jug_trigger_spawn(var1);
  thread jug_encounter_test(var1, 1);
}

function jug_encounter_test(var0, var1, var2) {
  level endon("game_ended");
  thread jeep_initdamage(var0, var1);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);
  self.ref_122f2 = 1;

  if(!isDefined(var2)) {
    var2 = 0.15;
  }

  wait var2;

  if(isDefined(self.explosion)) {
    self.explosion delete();
  }

  if(isDefined(self)) {
    self setscriptablepartstate("effects", "activeDestroyEnd", 0);
    return;
  }
}

function jeep_initdamage(var0, var1) {
  level endon("game_ended");
  self notify("disperse");
  self notify("death");
  self setscriptablepartstate("hack_usable", "off");
  self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_trophy", self.usedcount, var0, var1);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var1));
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

function jug_trigger_spawn(var0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0))) {
    var0 notify("destroyed_equipment");
    var0 thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    var0 thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    return;
  }
}

function jeep_horn() {
  var0 = spawn("script_model", self.origin);
  var0.killcament = self;
  var0.owner = self.owner;
  var0.team = self.team;
  var0.equipmentref = self.equipmentref;
  var0.weapon_name = self.weapon_name;
  var0 setotherent(var0.owner);
  var0 setentityowner(var0.owner);
  var0 setModel("trophy_system_mp_explode");
  var0.explode1available = 1;
  return var0;
}

function jeep_initcollision() {
  self endon("death");
  self endon("missile_stuck");
  var0 = getdvarfloat("scr_trophy_proj_hide_duration", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait var0;
  self setscriptablepartstate("visibility", "show", 0);
}

function jeep(var0) {
  self endon("death");
  self endon("missile_stuck");
  var0 endon("disconnect");
  var1 = scripts\engine\utility::ref_143b9(2, "touching_platform");

  if(var1 == "timeout") {
    return;
  }

  var2 = undefined;
  var3 = tablesort(self.origin, 500, 500);
  GscBinSkip0(0x2e, var3.size, self);
}

function tugofwar_tank(var0) {
  if(isDefined(level.ref_145f1)) {
    foreach(var2 in level.ref_145f1.ref_13c8d) {
      if(var2 == var0) {
        return true;
      }

      if(isDefined(var2.wz_tease) && var2.wz_tease == var0) {
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