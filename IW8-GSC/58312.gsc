/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58312.gsc
***********************************************/

function teamplunderexfiltimer() {
  if(isDefined(level.deposit_from_compromised_convoy_delayed)) {
    return;
  }

  level.disable_oob_immunity_on_riders = 1;
  level.deposit_from_compromised_convoy_delayed = spawnStruct();
  level.deposit_from_compromised_convoy_delayed.ref_12010 = undefined;
  level.deposit_from_compromised_convoy_delayed.ref_12011 = undefined;
  level.deposit_from_compromised_convoy_delayed.ref_1201e = undefined;
  level.deposit_from_compromised_convoy_delayed.ref_1363d = [];
  level.deposit_from_compromised_convoy_delayed.bisdeaf = ["actor_enemy_lw_br", "actor_enemy_lw_br_german_african", "zombie"];
  ambush_lmg_guy(level.deposit_from_compromised_convoy_delayed);
  allammoboxes();
  allassassin_getsortedteams();
  all_players_within_distance2d_and_below_height();
  scripts\cp_mp\vehicles\cargo_truck_mg::init_battlechatter();
}

function ambush_lmg_guy() {
  foreach(var_1 in level.deposit_from_compromised_convoy_delayed.bisdeaf) {
    ref_12b0b(var_1, &binoculars_watchracelaststand);
    ref_12b0c(var_1, &binoculars_watchracetake);
    ref_12b0d(var_1, &binocularsinited);
  }
}

function all_players_within_distance2d_and_below_height() {
  anim.grenadetimers["AI_gas_grenade_mp"] = randomintrange(0, 20000);
}

function allammoboxes() {
  var_0 = [["molotov_explosion", "vfx/iw8/core/molotov/vfx_molotov_explosion.vfx"], ["molotov_explosion_child", "vfx/iw8/core/molotov/vfx_molotov_explosion_child.vfx"], ["vfx_burn_sml_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx"], ["vfx_burn_sml_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_high.vfx"], ["vfx_burn_sml_head_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx"], ["vfx_burn_med_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx"], ["vfx_burn_med_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_high.vfx"], ["vfx_burn_lrg_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_low.vfx"], ["vfx_burn_lrg_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_high.vfx"]];

  if(!isDefined(level.g_effect)) {
    level.g_effect = [];
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(level.g_effect[var_0[var_1][0]])) {
      level.g_effect[var_0[var_1][0]] = loadfx(var_0[var_1][1]);
    }
  }
}

function allassassin_getsortedteams() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
    return;
  }
}

function spawnnewagent(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = "actor_enemy_lw_br";
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = "team_two_hundred";
  }

  var_5 = scripts\mp\mp_agent::spawnnewagent(var_3, var_4, var_0, var_1);

  if(!isDefined(var_5)) {
    return;
  }

  var_5.guid = var_5 getguid();
  ammobox_getbufferedattachmentsourceweapon(var_5);
  thread alwaysdoskyspawnontacinsert();
  thread activeparachutersfactionvo();
  scriptablecount(var_5, "s4_ar_voscar");
  thread activestate();

  if(var_2) {
    scriptable_token_scriptable_touched_callback(var_5, 250);
  }

  level.deposit_from_compromised_convoy_delayed.ref_1363d = scripts\engine\utility::array_add(level.deposit_from_compromised_convoy_delayed.ref_1363d, var_5);
  return var_5;
}

function spawnnewzombieagent(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = "enemy_lw_zombie_default";
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = "team_two_hundred";
  }

  var_6 = access_card::ref_146fa(var_3, var_0, var_1, undefined, var_4);

  if(!isDefined(var_6)) {
    return;
  }

  var_6.guid = var_6 getguid();
  thread activeparachutersfactionvo();
  var_6.use_updated_damage_modifiers = 1;

  if(var_2) {
    scriptable_token_scriptable_touched_callback(var_6, 250);
  }

  level.deposit_from_compromised_convoy_delayed.ref_1363d = scripts\engine\utility::array_add(level.deposit_from_compromised_convoy_delayed.ref_1363d, var_6);
  return var_6;
}

function spawnnewparachuteagent(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = "actor_enemy_lw_br";
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = "team_two_hundred";
  }

  var_5 = spawnnewagent(var_0, var_1, var_2, var_3, var_4);
  var_5 hide();
  var_5[[level.fnbrsoldierparachutespawn]](var_0);
  return var_5;
}

function ammobox_getbufferedattachmentsourceweapon() {
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.kills = 0;
  self.deaths = 0;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_death_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  self.tookweaponfrom = [];
  self.killedplayers = [];
  self.ref_1407d = 0;
  self.name = "agent_" + self.entity_number;
  self.scripted_long_deaths = 0;
  self.agentdamagefeedback = 1;
  self.maxhealth = 100;
  self.health = 100;
  self.health_remaining = 100;
  self.showseasonalcontent = 100;
  self.showsplashtoall = 100;
  self.meleedamageoverride = 25;
  self.baseaccuracy = 0.35;
  self.circleclosestarttime = spawnStruct();
  self.circleclosestarttime.maxhealth = self.maxhealth;
  self.circleclosestarttime.meleedamageoverride = self.meleedamageoverride;
  self.circleclosestarttime.baseaccuracy = self.baseaccuracy;
}

function activestate() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1, var_2, var_3);

    if(!scripts\mp\utility\weapon::grenadethrown(var_0)) {
      continue;
    }

    scripts\mp\weapons::grenadeinitialize(var_0, var_1, var_2, var_3);
    self notify("grenade_throw");

    if(!isDefined(var_0)) {
      return;
    }

    if(!isDefined(var_0.weapon_name)) {
      return;
    }

    var_0.spawnpos = var_0.origin;

    switch (var_0.weapon_name) {
      case "molotov_mp":
        thread scripts\mp\equipment\molotov::molotov_used(var_0);
        break;
      case "gas_grenade_mp":
        thread scripts\mp\equipment\gas_grenade::gas_used(var_0);
        wait 0.1;
        var_0 notify("missile_stuck");
        break;
    }
  }
}

function scriptable_token_scriptable_touched_callback(var_0) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_armor::teamfriendlyto();
    scripts\mp\gametypes\br_armor::searchcirclesize();
    ammobox_canweaponuserandomattachments(var_0);
    return;
  }
}

function scriptablecount(var_0, var_1) {
  self.weapon = scripts\mp\class::buildweapon(var_0, ["none", "none", "none", "none", "none", "none"], "none", "none", var_1);
  self giveweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;

  if(!scripts\common\utility::isweaponinitialized(self.primaryweapon)) {
    scripts\common\utility::initweapon(self.primaryweapon);
  }

  scripts\anim\shared::attachweapon(self.primaryweapon, "right");
}

function scriptable_used_by_part_funcs(var_0, var_1) {
  if(!isDefined(self.grenadeweapon) || self.grenadeweapon.basename != var_0) {
    self.grenadeweapon = getcompleteweaponname(var_0);
  }

  self.grenadeammo = var_1;
}

function alwaysdoskyspawnontacinsert() {
  self endon("death");
  level endon("game_ended");
  wait randomfloatrange(1.25, 2.75);
  scripts\cp_mp\vehicles\cargo_truck_mg::autoassignquest(self);
  scripts\cp_mp\vehicles\cargo_truck_mg::playorderevent("move", "movecombat", anim.player);
}

function ammobox_canweaponuserandomattachments(var_0) {
  if(!isDefined(var_0) || var_0 < 0) {
    return;
  }

  self.br_maxarmorhealth = var_0;
  self.br_armorhealth = var_0;
  var_1 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    self setclientomnvar("ui_br_armor_damage", var_1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
    return;
  }
}

function setagentmaxhealth(var_0) {
  self.maxhealth = var_0;
  self.health = var_0;
}

function ref_13122(var_0) {
  self.baseaccuracy = var_0;
}

function ref_13123(var_0) {
  self.meleedamageoverride = var_0;
}

function relic_mythic_next_pain_time() {
  return self.enemy;
}

function activeparachutersfactionvo() {
  level endon("game_ended");
  self waittill("death");
  level.deposit_from_compromised_convoy_delayed.ref_1363d = scripts\engine\utility::array_remove(level.deposit_from_compromised_convoy_delayed.ref_1363d, self);
}

function ref_12b0b(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  if(!isDefined(level.agent_funcs)) {
    return;
  }

  level.deposit_from_compromised_convoy_delayed.ref_12010 = var_1;
  level.agent_funcs[var_0]["on_damaged"] = var_1;
}

function ref_12b0c(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  if(!isDefined(level.agent_funcs)) {
    return;
  }

  level.deposit_from_compromised_convoy_delayed.ref_12011 = var_1;
  level.agent_funcs[var_0]["gametype_on_damage_finished"] = var_1;
}

function ref_12b0d(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  level.deposit_from_compromised_convoy_delayed.ref_1201e = var_1;
  level.agent_funcs[var_0]["gametype_on_killed"] = var_1;
}

function binoculars_watchracelaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_2;

  if(!istrue(self.ref_14693)) {
    scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    return;
  }
}

function binoculars_watchracetake(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(level.ref_1203f)) {
    if(scripts\engine\utility::isbulletdamage(var_4)) {
      if(isPlayer(var_1) || isbot(var_1) || isagent(var_1)) {
        self[[level.ref_1203f]](var_1, var_6, self);
      }
    }
  }

  if(!istrue(self.ref_14693)) {
    scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentgametypedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    return;
  }

  _zombieagentondamagefinishedcallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
}

function binocularsinited(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentgametypekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

function _zombieagentondamagefinishedcallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(self.zombie_callback_on_damage_finished)) {
    if(istrue(self.is_playing_spawn_performance)) {
      var_2 = int(var_2 * 0.5);
    }

    self[[self.zombie_callback_on_damage_finished]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, undefined, var_11, var_12);
    _zombieprocessarmordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isDefined(self.cursed_chest_on_damage_finished_callback)) {
      [[self.cursed_chest_on_damage_finished_callback]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    }

    scripts\mp\subway_fast_travel\subway_station::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self, var_13, var_14);
    return;
  }
}

function _zombieprocessarmordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(scripts\mp\gametypes\br_public::hasarmor()) {
    var_15 = var_2;

    if(istrue(self.hashelmet) && (var_8 == "head" || var_8 == "helmet")) {
      var_2 = int(var_2 * 0.07);
    }

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1 playsoundtoplayer("hit_marker_3d_armor", var_1);
    }

    scripts\mp\damage::armorvest_sethit(var_1);
    var_16 = self.br_armorhealth - var_2;
    self.health += var_15;
    self.br_armorhealth -= var_2;

    if(scripts\engine\utility::sign(var_16) == -1) {
      var_2 = int(abs(var_16));
      self.health -= var_2;
    }

    if(self.br_armorhealth <= 0) {
      self.br_armorhealth = 0;
      scripts\mp\damage::armorvest_setbroke(var_1);

      if(isDefined(self.attached_helmet)) {
        access_card::detachhelmetfromzombie(self.attached_helmet.model, self.attached_helmet.tag);
      }

      if(isDefined(var_1) && isPlayer(var_1)) {
        var_1 playsoundtoplayer("hit_marker_3d_armor_break", var_1);
        return;
      }

      return;
    }

    return;
  }
}