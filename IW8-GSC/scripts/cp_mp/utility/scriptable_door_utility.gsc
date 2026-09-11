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
  var0 = getscriptablearray("scriptable_veh_s4_mil_lnd_turret_quad_aa_wz_clip", "classname");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("clip", "enabled");
  }

  level.arenaflag_showflagoutlineplayer = [];
  level.arenaflag_setvisible = [];
  level.arenaflag_setenabled = &ref_134e5;
  var4 = scripts\engine\utility::getStructArray("aa_turret_spawn", "targetname");

  foreach(var6 in var4) {
    thread ref_134e5();
  }

  thread ref_11b1f();
}

function ref_134e5() {
  var0 = self;
  var1 = "manual_turret_flak_mp";

  if(getdvarint("aa_turrets_enabled", 0) == 2) {
    var1 = "manual_turret_flak_mp_highrof";
  }

  var2 = spawnturret("misc_turret", var0.origin, var1, 0);
  var2 unmarkkeyframedmover(1);

  if(getdvarint("aa_turret_map_debug", 0) == 1) {
    var3 = spawnStruct();
    var3 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(5, 0, 0, var0.origin);
    var3 scripts\mp\gametypes\br_quest_util::ref_1316f(3000);

    while(!isDefined(level.players[0])) {
      waitframe();
    }

    var3 scripts\mp\gametypes\br_quest_util::ref_1336a(level.players[0]);
  }

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var2.angles = var0.angles;
  var2 setModel("veh_s4_mil_lnd_turret_quad_aa_wz");
  var4 = "tag_player";
  var5 = var2 gettagorigin(var4);
  var5 -= anglesToForward(var0.angles) * 28;
  var2 setdefaultdroppitch(0);
  var2 setturretmodechangewait(1);
  var2.maxhealth = getdvarint("scr_br_aa_turret_hp", 1000);
  var2.health = var2.maxhealth;
  var2.spawnuniqueboardroomloot = 99;
  var2 setCanDamage(1);
  thread arena_turret_op_debug();
  var2 makeunusable();
  thread arenaflag_objectiveshow();
  thread arenaflag_showflagoutline(var0, var2);
  level.arenaflag_showflagoutlineplayer[level.arenaflag_showflagoutlineplayer.size] = var2;
  return var2;
}

function ref_11b1f() {
  level waittill("prematch_fade_done");
  level notify("match_start_reset_aa_turrets");

  foreach(var1 in level.arenaflag_showflagoutlineplayer) {
    if(!isDefined(var1)) {
      continue;
    }

    if(isDefined(var1.owner)) {
      arenaflag_setcaptured(var1);
    }

    if(isDefined(var1.useownerobj)) {
      var1.useownerobj delete();
    }

    if(isDefined(var1.playerzombieemp)) {
      stopFXOnTag(scripts\engine\utility::getfx("turret_damaged"), var1, "tag_battery_kl");
    }

    var1 delete();
  }

  if(isDefined(level.arenaknivesout)) {
    foreach(var4 in level.arenaknivesout) {
      var4 delete();
    }
  }

  level.arenaflag_showflagoutlineplayer = [];
  level.arenaknivesout = [];
  var6 = scripts\engine\utility::getStructArray("aa_turret_spawn", "targetname");

  foreach(var8 in var6) {
    thread ref_134e5();
  }
}

function arenaflag_setcaptured() {
  var0 = self;
  var1 = self.owner;

  if(isDefined(var1)) {
    var1 enableturretdismount();

    if(isDefined(var0)) {
      var1 controlturretoff(var0);
    }

    var1 setclientomnvar("ui_mobile_turret_controls", 0);
    var1 setclientomnvar("ui_veh_vehicle", -1);
    var1 setclientomnvar("ui_veh_controls", 0);
    var1 setclientomnvar("ui_veh_current_seat", -1);
    var1 setclientomnvar("ui_veh_occupant_0", -1);
    var1 setclientomnvar("ui_veh_health_percent", 0);
    var1 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("aa_turret");
    var1.nocorpse = undefined;
    var1.laststancechangetime = gettime();
    var1.pers["distTrackingPassed"] = undefined;
    var1 scripts\cp_mp\killstreaks\manual_turret::ref_11acd(1);

    if(var1 hasweapon("manual_turret_flak_mp")) {
      var1 takeweapon("manual_turret_flak_mp");
    }

    var1 scripts\mp\utility\inventory::switchtolastweapon();
    var1 thread scripts\cp_mp\killstreaks\manual_turret::ref_11ac7();
    return;
  }
}

function arenaflag_showflagoutline(var0, var1) {
  level endon("match_start_reset_aa_turrets");
  var0 endon("entitydeleted");
  var2 = self;

  while(isDefined(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject")) {
      var0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](var1, "HINT_BUTTON", undefined, &"MP_BR_INGAME/AA_TURRET_INTERACT", -1, "duration_none", undefined, 100, 60, 40, 60);
    }

    thread arenaflag_objectivehide();
    var0.useownerobj waittill("trigger", var3);
    var0.useownerobj delete();

    if(isDefined(var3.currentprimaryweapon) && isDefined(var3.currentprimaryweapon.basename) && var3.currentprimaryweapon.basename == "gasoline_can_mp") {
      var4 = var3 getplayerangles();
      var4 = (clamp(var4[0], -85, 85), scripts\engine\utility::absangleclamp180(var4[1]), 0);
      var5 = anglesToForward(var4);
      var6 = 90;
      var3.get_search_turret_target_player thread scripts\mp\equipment\binoculars::get_station_track_available_time_stamp(var5 * var6, var3);
    }

    if(isDefined(var3.carriable_set_dropped)) {
      if(var3 tagexists("j_bag_left")) {
        killfxontag(level._effect["vfx_br_cashLeaderBag"], var3, "j_bag_left");
      }

      var3 detach(var3.carriable_set_dropped, "tag_stowed_back3");
    }

    var7 = var3.origin;
    var3 scripts\cp_mp\killstreaks\manual_turret::ref_11acd(0);
    var3 disableturretdismount();
    var0.owner = var3;
    var0.team = var3.team;
    var3 giveweapon("manual_turret_flak_mp", -1, 0, -1, 1);
    var8 = var3 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("manual_turret_flak_mp", 1);

    if(!istrue(var8)) {
      if(isalive(var3)) {
        var3 enableturretdismount();
        var3 scripts\cp_mp\killstreaks\manual_turret::ref_11acd(1);

        if(var3 hasweapon("manual_turret_flak_mp")) {
          var3 takeweapon("manual_turret_flak_mp");
        }

        var3 scripts\mp\utility\inventory::switchtolastweapon();
      }

      continue;
    }

    var3.txt_nag = var3 controlturreton(var0);
    var3.nocorpse = 1;
    var3 setclientomnvar("ui_mobile_turret_controls", 1);
    var3 setclientomnvar("ui_veh_vehicle", 24);
    var3 setclientomnvar("ui_veh_controls", 1);
    var3 setclientomnvar("ui_veh_current_seat", 0);
    var3 setclientomnvar("ui_veh_occupant_0", 0);
    var3 setclientomnvar("ui_veh_health_percent", var0.spawnuniqueboardroomloot);
    var3 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("aa_turret");
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 setplayerangles(var0.angles);
    var0 setscriptablepartstate("sfx", "enter");
    var3 thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(var3, 2, 1);
    wait 2;

    if(scripts\mp\flags::gameflag("prematch_fade_done")) {
      while(isalive(var3) && !scripts\mp\utility\player::unset_relic_trex(var3) && !var3 useButtonPressed() && !var3 isinexecutionvictim()) {
        waitframe();
      }
    } else {
      while(isalive(var3) && !scripts\mp\utility\player::unset_relic_trex(var3) && !var3 useButtonPressed() && !var3 isinexecutionvictim() && !scripts\mp\flags::gameflag("prematch_fade_done")) {
        waitframe();
      }
    }

    if(isDefined(var0)) {
      var0 setscriptablepartstate("sfx", "exit");
    }

    if(isDefined(var3)) {
      var3 enableturretdismount();

      if(isDefined(var0)) {
        var3 controlturretoff(var0);
      }

      var3 setclientomnvar("ui_mobile_turret_controls", 0);
      var3 setclientomnvar("ui_veh_vehicle", -1);
      var3 setclientomnvar("ui_veh_controls", 0);
      var3 setclientomnvar("ui_veh_current_seat", -1);
      var3 setclientomnvar("ui_veh_occupant_0", -1);
      var3 setclientomnvar("ui_veh_health_percent", 0);
      var3 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("aa_turret");
      var3.nocorpse = undefined;
      var3.txt_nag = undefined;
      var3.laststancechangetime = gettime();
      var3 scripts\cp_mp\killstreaks\manual_turret::ref_11acd(1);

      if(var3 hasweapon("manual_turret_flak_mp")) {
        var3 takeweapon("manual_turret_flak_mp");
      }

      var3 scripts\mp\utility\inventory::switchtolastweapon();
      var3 thread scripts\cp_mp\killstreaks\manual_turret::ref_11ac7();
      var3 setOrigin(var7);
      var3 setplayerangles((var3.angles[0], var3.angles[1], 0));
    }

    if(isDefined(var0)) {
      var0.owner = undefined;
      var0 setotherent(undefined);
      var0 setentityowner(undefined);
    }

    if(isDefined(var3.carriable_set_dropped)) {
      var3 attach(var3.carriable_set_dropped, "tag_stowed_back3", 1, 1);

      if(var3 tagexists("j_bag_left")) {
        playFXOnTag(level._effect["vfx_br_cashLeaderBag"], var3, "j_bag_left");
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
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(self.owner) && isDefined(var1) && isPlayer(var1) && self.owner.team == var1.team) {
      self.health += var0;
      continue;
    }

    var1 thread scripts\mp\damagefeedback::updatedamagefeedback("hitequip");

    if(isDefined(var1) && isDefined(var1.vehicle) && isDefined(var1.vehicle.ref_13e92)) {
      if(var1.vehicle.ref_13e92 == "tur_gun_fd_mp_seeking") {
        self.health -= int(var0 * level.pindia_vehicle_registration);
      } else if(var1.vehicle.ref_13e92 == "tur_gun_bt_mp") {
        self.health -= int(var0 * level.findeventforchosenweight);
      }
    }

    if(var4 == "MOD_PROJECTILE" || var4 == "MOD_GRENADE" || var4 == "MOD_EXPLOSIVE" || var4 == "MOD_GRENADE_SPLASH" || var4 == "MOD_PROJECTILE_SPLASH") {
      self.health -= var0;
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

  var10 = spawn("script_model", self.origin);
  var10.angles = self.angles;
  playFX(scripts\engine\utility::getfx("turret_destroyed"), var10.origin);
  var10 setModel("veh_s4_mil_lnd_turret_quad_aa_wz_dmg");
  var10 setscriptablepartstate("expl_sfx", "expl");

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
    self.owner kill(self.origin, var1);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
      var1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]]("br_payload_killed_gunner", 500);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      var1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]]("br_payload_killed_gunner");
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("aa_turret", "destroyedTurretThink")) {
    var10 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("aa_turret", "destroyedTurretThink")]]();
  }

  if(!isDefined(level.arenaknivesout)) {
    level.arenaknivesout = [];
  }

  level.arenaknivesout[level.arenaknivesout.size] = var10;
  self delete();
}

function arenaflag_objectiveshow() {
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;

  while(isalive(self)) {
    if(isDefined(self.owner)) {
      if(!isDefined(var0)) {
        var0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
        arenaflag_onuncontested(var0, "ui_mp_br_icon_aa_turret_ally");
      }

      if(!isDefined(var1)) {
        var1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
        arenaflag_onuncontested(var1, "ui_mp_br_icon_aa_turret_enemy");
      }

      if(isDefined(var2)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var2);
        scripts\mp\objidpoolmanager::returnobjectiveid(var2);
        var2 = undefined;
      }

      scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var0, self.owner);
      scripts\mp\objidpoolmanager::objective_mask_showtoenemyteam(var1, self.owner);
    } else {
      if(isDefined(var0)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var0);
        scripts\mp\objidpoolmanager::returnobjectiveid(var0);
        var0 = undefined;
      }

      if(isDefined(var1)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var1);
        scripts\mp\objidpoolmanager::returnobjectiveid(var1);
        var1 = undefined;
      }

      if(!isDefined(var2)) {
        var2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
        arenaflag_onuncontested(var2, "ui_mp_br_icon_aa_turret");
      }

      scripts\mp\objidpoolmanager::objective_playermask_showtoall(var2);
    }

    waitframe();
  }

  if(isDefined(var0)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var0);
    scripts\mp\objidpoolmanager::returnobjectiveid(var0);
    var0 = undefined;
  }

  if(isDefined(var1)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var1);
    scripts\mp\objidpoolmanager::returnobjectiveid(var1);
    var1 = undefined;
  }

  if(isDefined(var2)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var2);
    scripts\mp\objidpoolmanager::returnobjectiveid(var2);
    var2 = undefined;
    return;
  }
}

function arenaflag_onuncontested(var0, var1) {
  objective_state(var0, "active");
  objective_position(var0, self.origin);
  playencryptedcinematicforall(var0, 1);
  objective_setplayintro(var0, 0);
  objective_setshowdistance(var0, 0);
  objective_setshowoncompass(var0, 0);
  function_0421(var0, 1);
  objective_setlabel(var0, "VEHICLES/AA_TURRET");
  scripts\mp\objidpoolmanager::update_objective_icon(var0, var1);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var0, 5);
}

function arenaflag_objectivehide() {
  self endon("entitydeleted");

  for(;;) {
    foreach(var1 in level.players) {
      if(istrue(var1.isjuggernaut)) {
        self hidefromplayer(var1);
        continue;
      }

      self showtoplayer(var1);
    }

    waitframe();
  }
}