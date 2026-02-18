/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_death_perception.gsc
************************************************/

#using script_18077945bb84ede7;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;
#namespace zm_perk_death_perception;

function private autoexec __init__system__() {
  system::register(#"zm_perk_death_perception", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  if(!is_true(getgametypesetting(#"hash_45fa8995b51490e8"))) {
    return;
  }

  enable_death_perception_perk_for_level();
}

function private postinit() {}

function enable_death_perception_perk_for_level() {
  callback::on_item_pickup(&on_item_pickup);
  zm_perks::register_perk_basic_info(#"talent_deathperception", #"perk_death_perception", 2000, #"hash_a81bac8ed8357c6", getweapon("zombie_perk_bottle_death_perception"), undefined, #"zmperksdeathperception");
  zm_perks::register_perk_precache_func(#"talent_deathperception", &function_f9d745da);
  zm_perks::register_perk_clientfields(#"talent_deathperception", &function_14ab8b5c, &function_a19424cd);
  zm_perks::register_perk_machine(#"talent_deathperception", &function_6bdb193c, &function_9b484511);
  zm_perks::register_perk_host_migration_params(#"talent_deathperception", "vending_deathperception", "deathperception_light");
  zm_perks::register_perk_threads(#"talent_deathperception", &function_79d54e51, &function_86a6368e);
}

function on_item_pickup(s_params) {
  itementry = s_params.item.itementry;

  if(itementry.itemtype === # "survival_scrap") {
    if(isPlayer(self)) {
      e_player = self;
    } else {
      e_player = s_params.player;
    }

    if(isPlayer(e_player)) {
      if(namespace_e86ffa8::function_cb561923(3)) {
        rarity = itementry.rarity;

        if(itementry.name === # "scrap_legendary_item_sr") {
          var_595a11bc = 25 * itementry.amount * 0.2;
          e_player namespace_2a9f256a::function_a6d4221f(var_595a11bc);
          return;
        }

        if(itementry.name === # "scrap_epic_item_sr") {
          var_595a11bc = 300 * itementry.amount * 0.2;
          e_player namespace_2a9f256a::function_afab250a(var_595a11bc);
          return;
        }

        if(itementry.name === # "scrap_item_harvesting_sr") {
          var_595a11bc = 200 * 0.2;
          e_player namespace_2a9f256a::function_afab250a(var_595a11bc);
          return;
        }

        if(rarity === # "rare") {
          var_595a11bc = 10 * itementry.amount * 0.2;
          e_player namespace_2a9f256a::function_a6d4221f(int(var_595a11bc));
          return;
        }

        var_595a11bc = 50 * itementry.amount * 0.2;
        e_player namespace_2a9f256a::function_afab250a(int(var_595a11bc));
      }
    }
  }
}

function function_9b484511() {}

function function_f9d745da() {
  level._effect[# "deathperception_light"] = "zombie/fx9_perk_death_perception";
  level.machine_assets[# "talent_deathperception"] = spawnStruct();
  level.machine_assets[# "talent_deathperception"].weapon = getweapon("zombie_perk_bottle_death_perception");
  level.machine_assets[# "talent_deathperception"].off_model = "p9_sur_machine_death_perception";
  level.machine_assets[# "talent_deathperception"].on_model = "p9_sur_machine_death_perception";
}

function function_14ab8b5c() {
  clientfield::register("scriptmover", "perk_death_perception_item_marked_for_rob", 15000, 1, "int");
  clientfield::register("toplayer", "perk_death_perception_visuals", 15000, 1, "int");
  clientfield::register("toplayer", "perk_death_perception_hud_warning", 15000, 1, "int");
  clientfield::register("toplayer", "perk_death_perception_visuals_items", 15000, 1, "int");
  clientfield::register("world", "dark_aether_crystal_check_dynentstate", 15000, 1, "counter");
}

function function_a19424cd(state) {}

function function_6bdb193c(use_trigger, perk_machine, bump_trigger, collision) {
  perk_machine.script_sound = "mus_perks_deathperception_jingle";
  perk_machine.script_string = "death_perception_perk";
  perk_machine.script_label = "mus_perks_deathperception_sting";
  perk_machine.target = "vending_deathperception";
  bump_trigger.script_string = "death_perception_perk";
  bump_trigger.targetname = "vending_deathperception";

  if(isDefined(collision)) {
    collision.script_string = "death_perception_perk";
  }
}

function function_79d54e51() {
  self clientfield::set_to_player("perk_death_perception_visuals", 1);

  if(namespace_e86ffa8::function_cb561923(2)) {
    self clientfield::set_to_player("perk_death_perception_hud_warning", 1);
  }

  if(namespace_e86ffa8::function_cb561923(5)) {
    self clientfield::set_to_player("perk_death_perception_visuals_items", 1);
  }
}

function function_86a6368e(b_pause, str_perk, str_result, n_slot) {
  self clientfield::set_to_player("perk_death_perception_visuals", 0);
  self clientfield::set_to_player("perk_death_perception_hud_warning", 0);
  self clientfield::set_to_player("perk_death_perception_visuals_items", 0);
}