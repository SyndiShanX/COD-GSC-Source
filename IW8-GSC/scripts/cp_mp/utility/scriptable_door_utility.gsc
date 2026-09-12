/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\scriptable_door_utility.gsc
*************************************************************/

function arenaballs() {
  if(!getdvarint("aa_turrets_enabled", 0)) {
    return;
  }

  level._effect["turret_damaged"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_aa_dmg_01.vfx");
  level._effect["turret_destroyed"] = loadfx("vfx/iw8_br/island/weap/_imp/turret/vfx_veh_explosion_turret.vfx");
  level waittill("player_spawned");
  var_0 = getscriptablearray("scriptable_veh_s4_mil_lnd_turret_quad_aa_wz_clip", "classname");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("clip", "enabled");
  }

  level.arenaflag_showflagoutlineplayer = [];
  level.arenaflag_setvisible = [];
  level.arenaflag_setenabled = &ref_134E5;
  var_4 = scripts\engine\utility::getStructArray("aa_turret_spawn", "targetname");

  foreach(var_6 in var_4) {
    thread ref_134E5();
  }

  thread ref_11B1F();
}

function ref_134E5() {
  var_0 = self;
  var_1 = "manual_turret_flak_mp";

  if(getdvarint("aa_turrets_enabled", 0) == 2) {
    var_1 = "manual_turret_flak_mp_highrof";
  }

  var_2 = spawnturret("misc_turret", var_0.origin, var_1, 0);
  var_2 unmarkkeyframedmover(1);

  if(getdvarint("aa_turret_map_debug", 0) == 1) {
    var_3 = spawnStruct();
    var_3 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(5, 0, 0, var_0.origin);
    var_3 scripts\mp\gametypes\br_quest_util::ref_1316F(3000);

    while(!isDefined(level.players[0])) {
      waitframe();
    }

    var_3 scripts\mp\gametypes\br_quest_util::ref_1336A(level.players[0]);
  }

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_2.angles = var_0.angles;
  var_2 setModel("veh_s4_mil_lnd_turret_quad_aa_wz");
  var_4 = "tag_player";
  var_5 = var_2 gettagorigin(var_4);
  var_5 -= anglesToForward(var_0.angles) * 28;
  var_2 setdefaultdroppitch(0);
  var_2 setturretmodechangewait(1);
  var_2.maxhealth = getdvarint("scr_br_aa_turret_hp", 1000);
  var_2.health = var_2.maxhealth;
  var_2.spawnuniqueboardroomloot = 99;
  var_2 setCanDamage(1);
  thread arena_turret_op_debug();
  var_2 makeunusable();
  thread arenaflag_objectiveshow();
  thread arenaflag_showflagoutline(var_0, var_2);
  level.arenaflag_showflagoutlineplayer[level.arenaflag_showflagoutlineplayer.size] = var_2;
  return var_2;
}

function ref_11B1F() {
  level waittill("prematch_fade_done");
  level notify("match_start_reset_aa_turrets");

  foreach(var_1 in level.arenaflag_showflagoutlineplayer) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(isDefined(var_1.owner)) {
      arenaflag_setcaptured(var_1);
    }

    if(isDefined(var_1.useownerobj)) {
      var_1.useownerobj delete();
    }

    if(isDefined(var_1.playerzombieemp)) {
      stopFXOnTag(scripts\engine\utility::getfx("turret_damaged"), var_1, "tag_battery_kl");
    }

    var_1 delete();
  }

  if(isDefined(level.arenaknivesout)) {
    foreach(var_4 in level.arenaknivesout) {
      var_4 delete();
    }
  }

  level.arenaflag_showflagoutlineplayer = [];
  level.arenaknivesout = [];
  var_6 = scripts\engine\utility::getStructArray("aa_turret_spawn", "targetname");

  foreach(var_8 in var_6) {
    thread ref_134E5();
  }
}

function arenaflag_setcaptured() {
  var_0 = self;
  var_1 = self.owner;

  if(isDefined(var_1)) {
    var_1 enableturretdismount();

    if(isDefined(var_0)) {
      var_1 controlturretoff(var_0);
    }

    var_1 setclientomnvar("ui_mobile_turret_controls", 0);
    var_1 setclientomnvar("ui_veh_vehicle", -1);
    var_1 setclientomnvar("ui_veh_controls", 0);
    var_1 setclientomnvar("ui_veh_current_seat", -1);
    var_1 setclientomnvar("ui_veh_occupant_0", -1);
    var_1 setclientomnvar("ui_veh_health_percent", 0);
    var_1 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("aa_turret");
    var_1.nocorpse = undefined;
    var_1.laststancechangetime = gettime();
    var_1.pers["distTrackingPassed"] = undefined;
    var_1 scripts\cp_mp\killstreaks\manual_turret::ref_11ACD(1);

    if(var_1 hasweapon("manual_turret_flak_mp")) {
      var_1 takeweapon("manual_turret_flak_mp");
    }

    var_1 scripts\mp\utility\inventory::switchtolastweapon();
    var_1 thread scripts\cp_mp\killstreaks\manual_turret::ref_11AC7();
    return;
  }
}

function arenaflag_showflagoutline(var_0, var_1) {
  level endon("match_start_reset_aa_turrets");
  var_0 endon("entitydeleted");
  var_2 = self;

  while(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject")) {
      var_0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](var_1, "HINT_BUTTON", undefined, &"MP_BR_INGAME/AA_TURRET_INTERACT", -1, "duration_none", undefined, 100, 60, 40, 60);
    }

    thread arenaflag_objectivehide();
    var_0.useownerobj waittill("trigger", var_3);
    var_0.useownerobj delete();

    if(isDefined(var_3.currentprimaryweapon) && isDefined(var_3.currentprimaryweapon.basename) && var_3.currentprimaryweapon.basename == "gasoline_can_mp") {
      var_4 = var_3 getplayerangles();
      var_4 = (clamp(var_4[0], -85, 85), scripts\engine\utility::absangleclamp180(var_4[1]), 0);
      var_5 = anglesToForward(var_4);
      var_6 = 90;
      var_3.get_search_turret_target_player thread scripts\mp\equipment\binoculars::get_station_track_available_time_stamp(var_5 * var_6, var_3);
    }

    if(isDefined(var_3.carriable_set_dropped)) {
      if(var_3 tagexists("j_bag_left")) {
        killfxontag(level._effect["vfx_br_cashLeaderBag"], var_3, "j_bag_left");
      }

      var_3 detach(var_3.carriable_set_dropped, "tag_stowed_back3");
    }

    var_7 = var_3.origin;
    var_3 scripts\cp_mp\killstreaks\manual_turret::ref_11ACD(0);
    var_3 disableturretdismount();
    var_0.owner = var_3;
    var_0.team = var_3.team;
    var_3 giveweapon("manual_turret_flak_mp", -1, 0, -1, 1);
    var_8 = var_3 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("manual_turret_flak_mp", 1);

    if(!istrue(var_8)) {
      if(isalive(var_3)) {
        var_3 enableturretdismount();
        var_3 scripts\cp_mp\killstreaks\manual_turret::ref_11ACD(1);

        if(var_3 hasweapon("manual_turret_flak_mp")) {
          var_3 takeweapon("manual_turret_flak_mp");
        }

        var_3 scripts\mp\utility\inventory::switchtolastweapon();
      }

      continue;
    }

    var_3.txt_nag = var_3 controlturreton(var_0);
    var_3.nocorpse = 1;
    var_3 setclientomnvar("ui_mobile_turret_controls", 1);
    var_3 setclientomnvar("ui_veh_vehicle", 24);
    var_3 setclientomnvar("ui_veh_controls", 1);
    var_3 setclientomnvar("ui_veh_current_seat", 0);
    var_3 setclientomnvar("ui_veh_occupant_0", 0);
    var_3 setclientomnvar("ui_veh_health_percent", var_0.spawnuniqueboardroomloot);
    var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("aa_turret");
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 setplayerangles(var_0.angles);
    var_0 setscriptablepartstate("sfx", "enter");
    var_3 thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(var_3, 2, 1);
    wait 2;

    if(scripts\mp\flags::gameflag("prematch_fade_done")) {
      while(isalive(var_3) && !scripts\mp\utility\player::unset_relic_trex(var_3) && !var_3 useButtonPressed() && !var_3 isinexecutionvictim()) {
        waitframe();
      }
    } else {
      while(isalive(var_3) && !scripts\mp\utility\player::unset_relic_trex(var_3) && !var_3 useButtonPressed() && !var_3 isinexecutionvictim() && !scripts\mp\flags::gameflag("prematch_fade_done")) {
        waitframe();
      }
    }

    if(isDefined(var_0)) {
      var_0 setscriptablepartstate("sfx", "exit");
    }

    if(isDefined(var_3)) {
      var_3 enableturretdismount();

      if(isDefined(var_0)) {
        var_3 controlturretoff(var_0);
      }

      var_3 setclientomnvar("ui_mobile_turret_controls", 0);
      var_3 setclientomnvar("ui_veh_vehicle", -1);
      var_3 setclientomnvar("ui_veh_controls", 0);
      var_3 setclientomnvar("ui_veh_current_seat", -1);
      var_3 setclientomnvar("ui_veh_occupant_0", -1);
      var_3 setclientomnvar("ui_veh_health_percent", 0);
      var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("aa_turret");
      var_3.nocorpse = undefined;
      var_3.txt_nag = undefined;
      var_3.laststancechangetime = gettime();
      var_3 scripts\cp_mp\killstreaks\manual_turret::ref_11ACD(1);

      if(var_3 hasweapon("manual_turret_flak_mp")) {
        var_3 takeweapon("manual_turret_flak_mp");
      }

      var_3 scripts\mp\utility\inventory::switchtolastweapon();
      var_3 thread scripts\cp_mp\killstreaks\manual_turret::ref_11AC7();
      var_3 setOrigin(var_7);
      var_3 setplayerangles((var_3.angles[0], var_3.angles[1], 0));
    }

    if(isDefined(var_0)) {
      var_0.owner = undefined;
      var_0 setotherent(undefined);
      var_0 setentityowner(undefined);
    }

    if(isDefined(var_3.carriable_set_dropped)) {
      var_3 attach(var_3.carriable_set_dropped, "tag_stowed_back3", 1, 1);

      if(var_3 tagexists("j_bag_left")) {
        playFXOnTag(level._effect["vfx_br_cashLeaderBag"], var_3, "j_bag_left");
      }
    }

    wait 0.5;
    LOC_0000041d:
  }
}

function arena_turret_op_debug() {
  level endon("match_start_reset_aa_turrets");
  self.health = 2000;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(self.owner) && isDefined(var_1) && isPlayer(var_1) && self.owner.team == var_1.team) {
      self.health += var_0;
      continue;
    }

    var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("hitequip");

    if(isDefined(var_1) && isDefined(var_1.vehicle) && isDefined(var_1.vehicle.ref_13E92)) {
      if(var_1.vehicle.ref_13E92 == "tur_gun_fd_mp_seeking") {
        self.health -= int(var_0 * level.pindia_vehicle_registration);
      } else if(var_1.vehicle.ref_13E92 == "tur_gun_bt_mp") {
        self.health -= int(var_0 * level.findeventforchosenweight);
      }
    }

    if(var_4 == "MOD_PROJECTILE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH") {
      self.health -= var_0;
    }

    self.spawnuniqueboardroomloot = int((self.health - 1000) / 1000 * 100);

    if(self.spawnuniqueboardroomloot == 100) {
      self.spawnuniqueboardroomloot = 99;
    }

    if(self.spawnuniqueboardroomloot < 30 && !isDefined(self.playerzombieemp)) {
      self.playerzombieemp = playFXOnTag(scripts\engine\utility::getfx("turret_damaged"), self, "tag_battery_kl");
    }

    if(self.spawnuniqueboardroomloot < 0) {
      self.spawnuniqueboardroomloot = 0;
    }

    if(isDefined(self.owner)) {
      self.owner setclientomnvar("ui_veh_health_percent", self.spawnuniqueboardroomloot);
    }

    if(self.health <= 1000) {
      break;
    }
  }

  var_10 = spawn("script_model", self.origin);
  var_10.angles = self.angles;
  playFX(scripts\engine\utility::getfx("turret_destroyed"), var_10.origin);
  var_10 setModel("veh_s4_mil_lnd_turret_quad_aa_wz_dmg");
  var_10 setscriptablepartstate("expl_sfx", "expl");

  if(isDefined(self.useownerobj)) {
    self.useownerobj delete();
  }

  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_mobile_turret_controls", 0);
    self.owner setclientomnvar("ui_veh_vehicle", -1);
    self.owner setclientomnvar("ui_veh_controls", 0);
    self.owner setclientomnvar("ui_veh_current_seat", -1);
    self.owner setclientomnvar("ui_veh_occupant_0", -1);
    self.owner setclientomnvar("ui_veh_health_percent", 0);
    self.owner.txt_nag = undefined;
    self.owner kill(self.origin, var_1);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]]("br_payload_killed_gunner", 500);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]]("br_payload_killed_gunner");
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("aa_turret", "destroyedTurretThink")) {
    var_10 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("aa_turret", "destroyedTurretThink")]]();
  }

  if(!isDefined(level.arenaknivesout)) {
    level.arenaknivesout = [];
  }

  level.arenaknivesout[level.arenaknivesout.size] = var_10;
  self delete();
}

function arenaflag_objectiveshow() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  while(isalive(self)) {
    if(isDefined(self.owner)) {
      if(!isDefined(var_0)) {
        var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
        arenaflag_onuncontested(var_0, "ui_mp_br_icon_aa_turret_ally");
      }

      if(!isDefined(var_1)) {
        var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
        arenaflag_onuncontested(var_1, "ui_mp_br_icon_aa_turret_enemy");
      }

      if(isDefined(var_2)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);
        scripts\mp\objidpoolmanager::returnobjectiveid(var_2);
        var_2 = undefined;
      }

      scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var_0, self.owner);
      scripts\mp\objidpoolmanager::objective_mask_showtoenemyteam(var_1, self.owner);
    } else {
      if(isDefined(var_0)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0);
        scripts\mp\objidpoolmanager::returnobjectiveid(var_0);
        var_0 = undefined;
      }

      if(isDefined(var_1)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_1);
        scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
        var_1 = undefined;
      }

      if(!isDefined(var_2)) {
        var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
        arenaflag_onuncontested(var_2, "ui_mp_br_icon_aa_turret");
      }

      scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_2);
    }

    waitframe();
  }

  if(isDefined(var_0)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0);
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0);
    var_0 = undefined;
  }

  if(isDefined(var_1)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_1);
    scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
    var_1 = undefined;
  }

  if(isDefined(var_2)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);
    scripts\mp\objidpoolmanager::returnobjectiveid(var_2);
    var_2 = undefined;
    return;
  }
}

function arenaflag_onuncontested(var_0, var_1) {
  objective_state(var_0, "active");
  objective_position(var_0, self.origin);
  playencryptedcinematicforall(var_0, 1);
  objective_setplayintro(var_0, 0);
  objective_setshowdistance(var_0, 0);
  objective_setshowoncompass(var_0, 0);
  function_0421(var_0, 1);
  objective_setlabel(var_0, "VEHICLES/AA_TURRET");
  scripts\mp\objidpoolmanager::update_objective_icon(var_0, var_1);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 5);
}

function arenaflag_objectivehide() {
  self endon("entitydeleted");

  for(;;) {
    foreach(var_1 in level.players) {
      if(istrue(var_1.isjuggernaut)) {
        self hidefromplayer(var_1);
        continue;
      }

      self showtoplayer(var_1);
    }

    waitframe();
  }
}