/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6c6a46b757ce4c71.gsc
*************************************************/

#using script_24fbedba9a7a1ef4;
#using script_54f6d121e91434f8;
#using scripts\anim\battlechatter;
#using scripts\anim\battlechatter_ai;
#using scripts\anim\squadmanager;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\equipment\disguise;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\mp_dialogue;
#using scripts\mp\weapons;
#namespace ob_humans;

function function_45657962a8ad47e() {
  if(!isDefined(level.ob)) {
    level.ob = spawnStruct();
  }

  level.ob.var_506f0668e5da48f6 = getdvarint(@ "hash_1e4e78ceaf845f5f", 29);
  level.ob.var_b41ff23edfc2a824 = getdvarint(@ "hash_7394d714a0c59e97", 36);
  level.ob.var_3ea1ae1f102fe42e = getdvarint(@ "hash_9bf73053c1203c33", 75);
  level.ob.var_e01042a086f3924d = getdvarint(@ "hash_eec3a89c0b85e9e2", 16);
  level.ob.var_275ff1f85d1b4c1c = getdvarint(@ "hash_e1b898f78901bc1f", 75);
  level.ob.var_e77101a6fc828c03 = getdvarint(@ "hash_15496964c5680db4", 90);
  level.ob.var_bbdcdae3439d9cec = getdvarfloat(@ "hash_df75a70307e74432", 0.6);
  flag_wait("ai_spawn_director_initialized");
  function_a4b670d860d7cf61();
  function_425f70bba2ca4d6b();
  function_90faf3f11984372a(3.45, 1, 1);
  function_e00cc8c1c5cc38fb(1);
  setDvar(@ "hash_f40118cb927a0802", 1);
  setDvar(@ "hash_877c52caf0f9aa8c", 40);

  function_3a2ca530d33dbb7c();
}

function private function_a4b670d860d7cf61() {
  level.var_aa78677d2156e18 = &function_20f21f6a7707e19;
  scripts\anim\battlechatter::init_battlechatter();
  scripts\mp\mp_dialogue::main();
  registersharedfunc("disguise", "disguiseNationalityOverride", &function_d76746a809428932);
  registersharedfunc("disguise", "disguiseOnUsed", &function_5555a1ab2616c388);
  registersharedfunc("disguise", "disguiseOff", &function_1aa05b7937a3b1a2);
  setDvar(@ "hash_8303972c0cfbece0", 0);
  registersharedfunc("disguise", "disguiseRegisterCustom", &function_c3a8389891d2f901);
  level thread scripts\mp\equipment\disguise::function_83599506981c29cd();
}

function function_20f21f6a7707e19() {
  level.battlechatter.eventstrings["rvnv"]["low_ammo"] = ["b035_defz_blam"];
  level.battlechatter.eventstrings["rvnv"]["left"] = ["b035_defz_blft"];
  level.battlechatter.eventstrings["rvnv"]["right"] = ["b035_defz_brgt"];
  level.battlechatter.eventstrings["rvnv"]["high"] = ["b035_defz_bhgh"];
  level.battlechatter.eventstrings["rvnv"]["order_attack"] = ["b035_defz_batk"];
  level.battlechatter.eventstrings["rvnv"]["using_smoke"] = ["b035_defz_busm"];
  level.battlechatter.eventstrings["rvnv"]["using_flash"] = ["b035_defz_bufl"];
  level.battlechatter.eventstrings["rvnv"]["using_grenade"] = ["b035_defz_bugr"];
  level.battlechatter.eventstrings["rvnv"]["using_molotov"] = ["b035_defz_buml"];
  level.battlechatter.eventstrings["rvnv"]["reloading"] = ["b035_defz_brld"];
  level.battlechatter.eventstrings["rvnv"]["moving"] = ["b035_defz_bmov"];
  level.battlechatter.eventstrings["rvnv"]["enemy_using_flash"] = ["b035_defz_befl"];
  level.battlechatter.eventstrings["rvnv"]["enemy_using_grenade"] = ["b035_defz_begr"];
  level.battlechatter.eventstrings["rvnv"]["enemy_using_molotov"] = ["b035_defz_beml"];
  level.battlechatter.eventstrings["rvnv"]["enemy_using_rpg"] = ["b035_defz_berp"];
  level.battlechatter.eventstrings["rvnv"]["enemy_attacking"] = ["b035_defz_beat"];
  level.battlechatter.eventstrings["rvnv"]["enemy_soldier"] = ["b035_defz_besd"];
  level.battlechatter.eventstrings["rvnv"]["enemy_soldiers"] = ["b035_defz_besm"];
  level.battlechatter.eventstrings["rvnv"]["aquired_target"] = ["b035_defz_btac"];
  level.battlechatter.eventstrings["rvnv"]["youre_exposed"] = ["b035_defz_bexp"];
  level.battlechatter.eventstrings["rvnv"]["target_covered"] = ["b035_defz_btcv"];
  level.battlechatter.eventstrings["rvnv"]["killfirm_enemy"] = ["b035_defz_bkfe"];
  level.battlechatter.eventstrings["rvnv"]["killfirm_target"] = ["b035_defz_bkft"];
  level.battlechatter.eventstrings["rvnv"]["killfirm_helo"] = ["b035_defz_bkfh"];
  level.battlechatter.eventstrings["rvnv"]["praise"] = ["b035_defz_bprs"];
  level.battlechatter.eventstrings["rvnv"]["wounded"] = ["b035_defz_bwnd"];
  level.battlechatter.eventstrings["rvnv"]["enemy_sniper"] = ["b035_defz_besn"];
  level.battlechatter.eventstrings["rvnv"]["checkfire"] = ["b035_defz_bchk"];
  level.battlechatter.eventstrings["rvnv"]["reviver"] = ["b035_defz_brvg"];
  level.battlechatter.eventstrings["jans"]["low_ammo"] = ["b017_exfa_blam"];
  level.battlechatter.eventstrings["jans"]["left"] = ["b017_exfa_blft"];
  level.battlechatter.eventstrings["jans"]["right"] = ["b017_exfa_brgt"];
  level.battlechatter.eventstrings["jans"]["high"] = ["b017_exfa_bhgh"];
  level.battlechatter.eventstrings["jans"]["order_attack"] = ["b017_exfa_batk"];
  level.battlechatter.eventstrings["jans"]["using_smoke"] = ["b017_exfa_busm"];
  level.battlechatter.eventstrings["jans"]["using_flash"] = ["b017_exfa_bufl"];
  level.battlechatter.eventstrings["jans"]["using_grenade"] = ["b017_exfa_bugr"];
  level.battlechatter.eventstrings["jans"]["using_molotov"] = ["b017_exfa_buml"];
  level.battlechatter.eventstrings["jans"]["reloading"] = ["b017_exfa_brld"];
  level.battlechatter.eventstrings["jans"]["moving"] = ["b017_exfa_bmov"];
  level.battlechatter.eventstrings["jans"]["enemy_using_flash"] = ["b017_exfa_befl"];
  level.battlechatter.eventstrings["jans"]["enemy_using_grenade"] = ["b017_exfa_begr"];
  level.battlechatter.eventstrings["jans"]["enemy_using_molotov"] = ["b017_exfa_beml"];
  level.battlechatter.eventstrings["jans"]["enemy_using_rpg"] = ["b017_exfa_berp"];
  level.battlechatter.eventstrings["jans"]["enemy_attacking"] = ["b017_exfa_beat"];
  level.battlechatter.eventstrings["jans"]["enemy_soldier"] = ["b017_exfa_besd"];
  level.battlechatter.eventstrings["jans"]["enemy_soldiers"] = ["b017_exfa_besm"];
  level.battlechatter.eventstrings["jans"]["aquired_target"] = ["b017_exfa_btac"];
  level.battlechatter.eventstrings["jans"]["youre_exposed"] = ["b017_exfa_bexp"];
  level.battlechatter.eventstrings["jans"]["target_covered"] = ["b017_exfa_btcv"];
  level.battlechatter.eventstrings["jans"]["killfirm_enemy"] = ["b017_exfa_bkfe"];
  level.battlechatter.eventstrings["jans"]["killfirm_target"] = ["b017_exfa_bkft"];
  level.battlechatter.eventstrings["jans"]["killfirm_helo"] = ["b017_exfa_bkfh"];
  level.battlechatter.eventstrings["jans"]["praise"] = ["b017_exfa_bprs"];
  level.battlechatter.eventstrings["jans"]["wounded"] = ["b017_exfa_bwnd"];
  level.battlechatter.eventstrings["jans"]["enemy_sniper"] = ["b017_exfa_besn"];
  level.battlechatter.eventstrings["jans"]["checkfire"] = ["b017_exfa_bchk"];
  level.battlechatter.eventstrings["flet"]["low_ammo"] = ["b25f_flet_blam"];
  level.battlechatter.eventstrings["flet"]["left"] = ["b25f_flet_blft"];
  level.battlechatter.eventstrings["flet"]["right"] = ["b25f_flet_brgt"];
  level.battlechatter.eventstrings["flet"]["high"] = ["b25f_flet_bhgh"];
  level.battlechatter.eventstrings["flet"]["order_attack"] = ["b25f_flet_batk"];
  level.battlechatter.eventstrings["flet"]["using_smoke"] = ["b25f_flet_busm"];
  level.battlechatter.eventstrings["flet"]["using_flash"] = ["b25f_flet_bufl"];
  level.battlechatter.eventstrings["flet"]["using_grenade"] = ["b25f_flet_bugr"];
  level.battlechatter.eventstrings["flet"]["using_molotov"] = ["b25f_flet_buml"];
  level.battlechatter.eventstrings["flet"]["reloading"] = ["b25f_flet_brld"];
  level.battlechatter.eventstrings["flet"]["moving"] = ["b25f_flet_bmov"];
  level.battlechatter.eventstrings["flet"]["enemy_using_flash"] = ["b25f_flet_befl"];
  level.battlechatter.eventstrings["flet"]["enemy_using_grenade"] = ["b25f_flet_begr"];
  level.battlechatter.eventstrings["flet"]["enemy_using_molotov"] = ["b25f_flet_beml"];
  level.battlechatter.eventstrings["flet"]["enemy_using_rpg"] = ["b25f_flet_berp"];
  level.battlechatter.eventstrings["flet"]["enemy_attacking"] = ["b25f_flet_beat"];
  level.battlechatter.eventstrings["flet"]["enemy_soldier"] = ["b25f_flet_besd"];
  level.battlechatter.eventstrings["flet"]["enemy_soldiers"] = ["b25f_flet_besm"];
  level.battlechatter.eventstrings["flet"]["aquired_target"] = ["b25f_flet_btac"];
  level.battlechatter.eventstrings["flet"]["youre_exposed"] = ["b25f_flet_bexp"];
  level.battlechatter.eventstrings["flet"]["target_covered"] = ["b25f_flet_btcv"];
  level.battlechatter.eventstrings["flet"]["killfirm_enemy"] = ["b25f_flet_bkfe"];
  level.battlechatter.eventstrings["flet"]["killfirm_target"] = ["b25f_flet_bkft"];
  level.battlechatter.eventstrings["flet"]["killfirm_helo"] = ["b25f_flet_bkfh"];
  level.battlechatter.eventstrings["flet"]["praise"] = ["b25f_flet_bprs"];
  level.battlechatter.eventstrings["flet"]["wounded"] = ["b25f_flet_bwnd"];
  level.battlechatter.eventstrings["flet"]["enemy_sniper"] = ["b25f_flet_besn"];
  level.battlechatter.eventstrings["flet"]["checkfire"] = ["b25f_flet_bchk"];
  level.battlechatter.eventstrings["jans"]["need_revive"] = ["b017_exfa_bdwn"];
  level.battlechatter.eventstrings["jans"]["been_revived"] = ["b017_exfa_brvd"];
  level.battlechatter.eventstrings["jans"]["reviver"] = ["b017_exfa_brvg"];
  scripts\anim\battlechatter::addevent("need_revive", "need_revive", 0, 2, 5);
  scripts\anim\battlechatter::addevent("been_revived", "been_revived", 0, 2, 5);
  scripts\anim\battlechatter::addevent("reviver", "reviver", 0, 2, 5);
}

function private function_425f70bba2ca4d6b() {
  level scripts\common\callbacks::add("on_agent_spawned", &function_7e2e3e062b49f13b);
  registersharedfunc("ai_mp_controller", "agentPers_getAgentPersData", &scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata);
  registersharedfunc("ai_mp_controller", "agentPers_setAgentPersData", &scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata);
  registersharedfunc("ai_mp_controller", "handleDamageFeedback", &scripts\mp\damage::handledamagefeedback);
  registersharedfunc("vehicle_damage", "modifyVehicleDamage", &function_431dee4c36d7e3ba);
  level.agent_funcs["soldier"]["on_damaged"] = &namespace_daa149ca485fd50a::callbacksoldieragentdamaged;
  level.agent_funcs["soldier"]["gametype_on_killed"] = &scripts\mp\mp_agent_damage::callbacksoldieragentgametypekilled;
  level.createrpgrepulsors = 0;
}

function private function_7e2e3e062b49f13b(params) {
  agent = params.agent;

  if(agent.unittype == "soldier") {
    if(isDefined(agent.subclass)) {
      switch (agent.subclass) {
        case #"hash_91cd18ea8bf6d95":
          function_125032d40c0a1677(agent);
          break;
        case #"hash_5a24fffee0d81302":
        case #"hash_6bd0663d453b9ee4":
        case #"hash_e907579ab7e94379":
        case #"hash_ef4c998bcc00f823":
        case #"hash_f4609eba318d1829":
          function_125033d40c0a18aa(agent);
          break;
        case #"hash_3c0ffb3dab1a9835":
        case #"hash_806a6487959205af":
        case #"hash_9fdf20303effa2d0":
        case #"hash_9fdf21303effa463":
        case #"hash_9fdf28303effaf68":
        case #"hash_9fdf2a303effb28e":
        case #"hash_9fdf2b303effb421":
        case #"hash_9fdf2c303effb5b4":
        case #"hash_9fdf2d303effb747":
        case #"hash_9fdf2f303effba6d":
        case #"hash_a02d9e303f3d3ee9":
        case #"hash_abfb9bf32c810788":
        case #"hash_c9beeb2ff7f370db":
          function_125034d40c0a1add(agent);
          break;
        case #"hash_3794ac3fadfffd9c":
          function_65162bac204e8044(agent);
        case #"hash_b32707f6c3892f15":
          function_3043f74f8b90b7dd(agent);
        default:
          break;
      }
    }

    agent thread scripts\anim\squadmanager::addtosquad();

    if(is_equal(agent.agent_type, "actor_jup_ob_ally_ava_base")) {
      agent scripts\anim\battlechatter_ai::setup_mp_hero("jans", "b017", "b017");
    }

    if(is_equal(agent.agent_type, "actor_jup_ob_ally_ravenov_base")) {
      agent scripts\anim\battlechatter_ai::setup_mp_hero("rvnv", "b035", "b035");
    }

    if(is_equal(agent.agent_type, "jup_ob_ally_fletcher_base")) {
      agent scripts\anim\battlechatter_ai::setup_mp_hero("flet", "b25", "b25");
    }

    agent thread scripts\mp\weapons::watchgrenadeusage();
    agent.var_8c5c47f81a1869e5 = &namespace_daa149ca485fd50a::function_7d0d24665d72f13c;
    agent.var_cd6a3a50f09688b9 = &namespace_daa149ca485fd50a::function_59ea6b2f800cb082;
    agent.dontdamageriotshield = 1;
  }
}

function private function_3043f74f8b90b7dd(agent) {
  agent.var_2d670e4d288c86fb = 1;
  agent.var_526f1dcf41e8b261 = getdvarfloat(@ "hash_1adf88fd35fbac70", 5.8);
  agent.var_46f376c7b944859b = getdvarfloat(@ "hash_10cacdc3eb0966e", 3.3);

  if(isDefined(agent.armorhealth) && agent.armorhealth > 0) {
    agent.minpaindamage = int(agent.armorhealth / 2);
  }

  agent.baseaccuracy = getdvarfloat(@ "hash_a02664619d86b8c9", 0.85);
  agent.var_4268b42fc89d0be9 = 0.08;
  agent.var_8a783f4c73c2ae91 = 0.0003;
  agent.gameskillmisstimefrombehindoverride = 0.7;
}

function private function_65162bac204e8044(agent) {
  agent.var_9aa77ab756fdca82 = 100;
  agent.var_43e2ad424676b8d4 = 60;
  agent.paincooldown = 3000;
  agent.baseaccuracy = getdvarfloat(@ "hash_a02664619d86b8c9", 0.85);
  agent.var_526f1dcf41e8b261 = getdvarfloat(@ "hash_1adf88fd35fbac70", 5.8);
  agent.var_4268b42fc89d0be9 = 0.04;
  agent.var_8a783f4c73c2ae91 = 0.0001;
  agent.gameskillmisstimefrombehindoverride = 0.4;
}

function private function_125032d40c0a1677(agent) {
  agent.var_9aa77ab756fdca82 = 10;
  agent.var_43e2ad424676b8d4 = 10;
  agent.baseaccuracy = getdvarfloat(@ "hash_a02661619d86b230", 0.55);
  agent.var_526f1dcf41e8b261 = getdvarfloat(@ "hash_d402fcc65515a733", 3);
  agent.var_4268b42fc89d0be9 = getdvarfloat(@ "hash_8dfb6d4ecad5411b", 0.12);
  agent.var_8a783f4c73c2ae91 = 0.0006;
  agent.gameskillmisstimefrombehindoverride = 0.7;
  agent function_8bbcaeb23a1512ef("all", 1);
  agent function_859a90c664dba240(1);
  agent function_136adff8f817fad6(0);

  if(isdvardefined(@ "hash_e5a2fe52e7fd74d7")) {
    agent.maxarmorhealth = getdvarint(@ "hash_e5a2fe52e7fd74d7");
    agent.armorhealth = getdvarint(@ "hash_e5a2fe52e7fd74d7");
  }

  if(isdvardefined(@ "hash_bcd6c3f5ca11d056")) {
    agent.health = getdvarint(@ "hash_bcd6c3f5ca11d056");
    agent.maxhealth = getdvarint(@ "hash_bcd6c3f5ca11d056");
  }
}

function private function_125033d40c0a18aa(agent) {
  agent.var_9aa77ab756fdca82 = 150;
  agent.var_43e2ad424676b8d4 = 30;
  agent.baseaccuracy = getdvarfloat(@ "hash_a02664619d86b8c9", 0.85);
  agent.var_526f1dcf41e8b261 = getdvarfloat(@ "hash_1adf88fd35fbac70", 5.8);
  agent.suppressionthreshold = 0.4;
  agent.suppressiondecrement = 0.2;
  agent.var_2a4784c6cc07ca59 = 0.05;

  if(agent.subclass == "ob_sniper") {
    agent function_9215ce6fc83759b9(4646);
    agent function_d493e7fe15e5eaf4("jup_sandbox_sniper");
    setdvarifuninitialized(@ "hash_de2405a9f72799dd", agent.baseaccuracy);
    agent.baseaccuracy = getdvarfloat(@ "hash_de2405a9f72799dd");
  }

  agent.var_4268b42fc89d0be9 = getdvarfloat(@ "hash_29c7e9e562be2374", 0.04);
  agent.var_8a783f4c73c2ae91 = 0.0001;
  agent.gameskillmisstimefrombehindoverride = 0.6;
  agent function_8bbcaeb23a1512ef("all", 1);
  agent function_859a90c664dba240(1);
  agent function_136adff8f817fad6(1);

  if(isdvardefined(@ "hash_c8e0804febe485ce")) {
    agent.maxarmorhealth = getdvarint(@ "hash_c8e0804febe485ce");
    agent.armorhealth = getdvarint(@ "hash_c8e0804febe485ce");
  }

  if(isdvardefined(@ "hash_7366919330cee7b1")) {
    agent.maxhealth = getdvarint(@ "hash_7366919330cee7b1");
    agent.health = getdvarint(@ "hash_7366919330cee7b1");
  }
}

function private function_125034d40c0a1add(agent) {
  agent.var_9aa77ab756fdca82 = 450;
  agent.var_43e2ad424676b8d4 = 100;
  agent.baseaccuracy = getdvarfloat(@ "hash_a02663619d86b696", 1.15);
  agent.aggressivemode = 1;
  agent.var_cbd87a0bc497b778 = 1;
  agent.var_526f1dcf41e8b261 = getdvarfloat(@ "hash_9fb6065532820021", 8.6);
  agent.suppressionthreshold = 0.25;
  agent.suppressiondecrement = 0.25;
  agent.var_2a4784c6cc07ca59 = 0.05;
  agent.var_4268b42fc89d0be9 = getdvarfloat(@ "hash_28d87a7d205c119", 0.02);
  agent.var_8a783f4c73c2ae91 = 8e-05;
  agent.gameskillmisstimefrombehindoverride = 0.4;
  agent.var_98add129a7ecb962 = 0;

  if(agent.subclass == "ob_tactician") {
    agent.disablelmgmount = 1;
  }

  agent function_8bbcaeb23a1512ef("all", 1);
  agent function_859a90c664dba240(1);
  agent function_136adff8f817fad6(1);

  if(isdvardefined(@ "hash_4227d53e5aece55d")) {
    agent.maxarmorhealth = getdvarint(@ "hash_4227d53e5aece55d");
    agent.armorhealth = getdvarint(@ "hash_4227d53e5aece55d");
  }

  if(isdvardefined(@ "hash_ac59bb34c9d0f0bc")) {
    agent.maxhealth = getdvarint(@ "hash_ac59bb34c9d0f0bc");
    agent.health = getdvarint(@ "hash_ac59bb34c9d0f0bc");
  }
}

function private function_431dee4c36d7e3ba(inflictor, objweapon, damage) {
  if(!isDefined(inflictor) || !isagent(inflictor)) {
    return damage;
  }

  isplayervehicle = isDefined(self) && isDefined(self.owner) && isPlayer(self.owner);

  if(!isplayervehicle) {
    return damage;
  }

  maxdamage = undefined;

  if(isDefined(objweapon)) {
    class = weaponclass(objweapon);

    if(isDefined(class)) {
      switch (class) {
        case #"hash_690c0d6a821b42e":
          maxdamage = level.var_9cf526926a72864c;
          break;
        default:
          break;
      }
    }
  }

  if(isDefined(maxdamage)) {
    return min(damage, maxdamage);
  }

  return damage;
}

function function_cf5321434f9b38c1(idamage, smeansofdeath, objweapon) {
  maxdamage = undefined;
  invehicle = player_utility::isinvehicle();

  if(invehicle && isDefined(level.ob.var_bbdcdae3439d9cec)) {
    idamage = int(idamage * level.ob.var_bbdcdae3439d9cec);
  }

  class = weaponclass(objweapon);

  switch (class) {
    case #"hash_8cdaf2e4ecfe5b51":
    case #"hash_fa24dff6bd60a12d":
      maxdamage = level.ob.var_b41ff23edfc2a824;
      break;
    case #"hash_6191aaef9f922f96":
      maxdamage = level.ob.var_3ea1ae1f102fe42e;
      break;
    case #"hash_690c0d6a821b42e":
      maxdamage = level.ob.var_e01042a086f3924d;
      break;
    default:
      if(isexplosivedamagemod(smeansofdeath)) {
        maxdamage = level.ob.var_275ff1f85d1b4c1c;
      } else if(smeansofdeath == "MOD_MELEE") {
        maxdamage = level.ob.var_e77101a6fc828c03;
      } else if(smeansofdeath == "MOD_SUICIDE") {
        maxdamage = idamage;
      } else {
        maxdamage = level.ob.var_506f0668e5da48f6;
      }

      break;
  }

  if(isDefined(maxdamage)) {
    idamage = min(idamage, maxdamage);
  }

  return idamage;
}

function private function_d76746a809428932() {
  return "ob_sergeant";
}

function private function_5555a1ab2616c388() {
  function_f3bb4f4911a1beb2("player", "setIgnoredByMercs", "disguise", 1);
  function_f8b0de2db7cf5546(0.5, 0);
}

function private function_1aa05b7937a3b1a2() {
  function_f3bb4f4911a1beb2("player", "setIgnoredByMercs", "disguise", 0);
  function_235231abd6580e1e();
}

function private function_c3a8389891d2f901() {
  scripts\mp\equipment\disguise::function_4981209c2c509828("ob_sergeant", "body_c_jup_sp_enemy_pmc_capt_03", "head_sc_m_jimenez", "mp_vm_opforce_shadow_company_elite_1_1", "vestlight", "millightgr");
}

function private function_f8b0de2db7cf5546(fadeintime, delaytime) {
  self.var_c173aed9da5b3286 = newclienthudelem(self);
  self.var_c173aed9da5b3286.x = 0;
  self.var_c173aed9da5b3286.y = 0;
  self.var_c173aed9da5b3286.alignx = "left";
  self.var_c173aed9da5b3286.aligny = "top";
  self.var_c173aed9da5b3286.horzalign = "fullscreen";
  self.var_c173aed9da5b3286.vertalign = "fullscreen";
  self.var_c173aed9da5b3286 setshader("disguise_sergeant_beret", 640, 480);
  self.var_c173aed9da5b3286.sort = -5;
  self.var_c173aed9da5b3286.archived = 1;
  self.var_c173aed9da5b3286.scramblerdisabled = 1;

  if(issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[getsharedfunc("game", "isBRStyleGameType")]]()) {
      self.var_c173aed9da5b3286.alpha = 0;

      if(isDefined(fadeintime)) {
        if(isDefined(delaytime)) {
          wait delaytime;
        }

        if(isDefined(self.var_c173aed9da5b3286)) {
          self.var_c173aed9da5b3286 fadeovertime(fadeintime);
        }
      }
    }
  }

  if(isDefined(self.var_c173aed9da5b3286)) {
    self.var_c173aed9da5b3286.alpha = 1;
    self.var_c173aed9da5b3286.lowresbackground = 1;
  }
}

function private function_235231abd6580e1e(fadeouttime, delaytime) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.var_c173aed9da5b3286)) {
    return;
  }

  if(isDefined(fadeouttime)) {
    if(isDefined(delaytime)) {
      wait delaytime;
    }

    if(isDefined(self.var_c173aed9da5b3286)) {
      self.var_c173aed9da5b3286.alpha = 1;
      self.var_c173aed9da5b3286 fadeovertime(fadeouttime);
      self.var_c173aed9da5b3286.alpha = 0;
      wait fadeouttime;
    }
  }

  if(isDefined(self.var_c173aed9da5b3286)) {
    self.var_c173aed9da5b3286 destroy();
    self.var_c173aed9da5b3286 = undefined;
  }
}

function private function_3a2ca530d33dbb7c() {
  thread function_bc8f27e3d1eef91e();
  devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x33>", "<dev string:x48>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x70>", "<dev string:x81>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:xaa>", "<dev string:xba>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:xe2>", "<dev string:xf5>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x120>", "<dev string:x132>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x15c>", "<dev string:x172>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x19d>", "<dev string:x1b2>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x1dc>", "<dev string:x1fa>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x223>", "<dev string:x245>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x26f>", "<dev string:x27a>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x29f>", "<dev string:x2b2>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x2d9>", "<dev string:x2e6>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x30a>", "<dev string:x328>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x351>", "<dev string:x35b>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x37f>", "<dev string:x389>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x3ad>", "<dev string:x3b9>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x3df>", "<dev string:x3e9>", &function_ef3da4a8b1880c27);
  devgui::function_b23a59dfb4ca49a1("<dev string:x40d>", "<dev string:x415>", &function_ef3da4a8b1880c27);
  devgui::function_fe953f000498048f();
}

function function_ef3da4a8b1880c27(spawntag) {
  firstplayer = level.players[0];
  playerforward = anglesToForward(firstplayer.angles);
  offsetposition = firstplayer.origin + playerforward * 100 + (0, 0, 10);
  encounterid = scripts\cp_mp\agents\ai_spawn_director::spawn_request("<dev string:x437>", offsetposition, 32, 0, 1, 0);
  function_d37068aac7785c04(encounterid, spawntag[0], 1);
  function_fc38783a3da0bc71(encounterid, 1);
}

function function_bc8f27e3d1eef91e() {
  level endon("<dev string:x459>");
  setdevdvarifuninitialized(@ "hash_f9e17cb98b253864", 0);
  var_4aedb83e4489153d = 1;

  while(true) {
    if(int(getunarchiveddebugdvar(@ "hash_f9e17cb98b253864", "<dev string:x467>")) > 0 && var_4aedb83e4489153d) {
      var_4aedb83e4489153d = 0;
      setDvar(@ "hash_f51f34be092e6691", 1);
      setDvar(@ "debug_stealth", 1);
      setDvar(@ "ai_showpaths", 1);
      setDvar(@ "hash_c7b59c90cd6d06bb", 1);
    }

    if(int(getunarchiveddebugdvar(@ "hash_f9e17cb98b253864", "<dev string:x467>")) == 0 && !var_4aedb83e4489153d) {
      var_4aedb83e4489153d = 1;
      setDvar(@ "hash_f51f34be092e6691", 0);
      setDvar(@ "debug_stealth", 0);
      setDvar(@ "ai_showpaths", 0);
      setDvar(@ "hash_c7b59c90cd6d06bb", 0);
    }

    waitframe();
  }
}

function function_d170903981c617de(player) {
  var_557c51a81144b954 = 0;

  if(isDefined(player.activities) && isDefined(player.activities.var_6ff9941006fb29cd)) {
    var_557c51a81144b954 = player.activities.var_6ff9941006fb29cd.size;
  }

  function_5c0adb7451b9af7a(player, "<dev string:x46c>" + var_557c51a81144b954 + "<dev string:x492>");

  if(var_557c51a81144b954 > 0) {
    foreach(var_85afed0f5a7270c4, var_3433cfdaabb0b969 in player.activities.var_6ff9941006fb29cd) {
      var_e8b975085b1b28e3 = player.activities.var_6346961d07f668fe == var_85afed0f5a7270c4;
      activityinstance = level.activities.instances[var_85afed0f5a7270c4];

      if(isDefined(activityinstance)) {
        activitytag = activityinstance.varianttag;
        activitytype = activityinstance.type;
        var_8a82ef4a9c0fccc2 = 0;

        if(isDefined(activityinstance.var_741c4f3150e30c83)) {
          var_8a82ef4a9c0fccc2 = function_93587d5ba6247f36(activityinstance.var_741c4f3150e30c83, player);
        }

        function_5c0adb7451b9af7a(player, "<dev string:x49e>" + activitytag + "<dev string:x4c4>" + activitytype + "<dev string:x4d1>" + "<dev string:x4d6>" + var_e8b975085b1b28e3 + "<dev string:x4d1>" + "<dev string:x4e4>" + var_8a82ef4a9c0fccc2 + "<dev string:x4d1>");
      }
    }
  }
}

function function_629369a1a5cd2636(text) {
  shouldlog = int(getDvar(@ "hash_6e561210fe14f90c", 0));

  if(shouldlog > 0) {
    if(isstartstr(text, "<dev string:x4fe>")) {
      println("<dev string:x503>" + text);
      return;
    }

    println("<dev string:x514>" + text);
  }
}

function function_f7e877aa7e97d952(activityinstance, text) {
  if(isDefined(activityinstance) && isDefined(activityinstance.varianttag)) {
    function_629369a1a5cd2636("<dev string:x4fe>" + activityinstance.varianttag + "<dev string:x526>" + text);
  }
}

function function_5c0adb7451b9af7a(player, text) {
  if(isDefined(player) && isPlayer(player)) {
    function_629369a1a5cd2636("<dev string:x52c>" + player.clientid + "<dev string:x526>" + text);
  }
}

function function_dd0ceeddc603cb3e(player, activityinstance, text) {
  if(isDefined(player) && isPlayer(player) && isDefined(activityinstance) && isDefined(activityinstance.varianttag)) {
    function_629369a1a5cd2636("<dev string:x52c>" + player.clientid + "<dev string:x538>" + activityinstance.varianttag + "<dev string:x526>" + text);
  }
}

# /