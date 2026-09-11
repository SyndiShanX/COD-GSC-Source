/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58315.gsc
***********************************************/

function bot_allowed_to_try_last_loadout() {
  level endon("game_ended");
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_done");
  level.are_all_hvts_eliminated = [];
  level.next_drone_cd = &next_drone_cd;
  level.arena_bot_get_total_gun_ammo = getEntArray("br_ai_spawn_trigger", "targetname");
  scripts\engine\utility::array_thread(level.arena_bot_get_total_gun_ammo, &bot_affirm);
  level.spawnziptie = getdvarint("scr_default_maxagents", 15);
}

function bot_affirm() {
  level endon("game_ended");
  var_0 = self;

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isagent(var_1)) {
      continue;
    }

    break;
  }

  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
      if(level.are_all_hvts_eliminated.size >= level.spawnziptie) {
        break;
      }

      if(getdvarint("scr_br_ai_parachuteSpawn", 0) == 1 && istrue(var_5.„ù¸ ? ¯ã + Ã† fû› û {
            NëKpÐã - {
            )) {
            var_6 = thread _testing_ending::spawnnewparachuteagent(var_5.origin, var_5.angles, 1, "actor_enemy_lw_br_german_african");
          } else {
            var_6 = thread _testing_ending::spawnnewagent(var_5.origin, var_5.angles, 1, "actor_enemy_lw_br_german_african");
          }

          level.are_all_hvts_eliminated = scripts\engine\utility::array_add(level.are_all_hvts_eliminated, var_6);

          if(isDefined(var_5.script_noteworthy)) {
            var_6.script_noteworthy = var_5.script_noteworthy;
          }

          bot_capture_koth_zone(var_6); bomb_detonator_bomb_type(var_6); var_3 = scripts\engine\utility::array_add(var_3, var_6); var_7 = getEnt(var_5.target, "targetname");

          if(!isDefined(var_7)) {
            continue;
          }

          if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "delay_goal_volume") {
            blueprintcreatingteam(var_6, var_7);
          } else {
            var_6 setgoalvolumeauto(var_7);

            if(isPlayer(var_1)) {
              var_6 agentsetfavoriteenemy(var_1);
              var_6 getenemyinfo(var_1);
            }
          }

          if(isDefined(level.ref_11ffd) && isbuiltinfunction(level.ref_11ffd)) {
            [[level.ref_11ffd]](var_6, var_0);
          }
        }
      }

      function bot_capture_koth_zone() {
        self.guid = self getguid();
        self.name = self.guid;
        self.agentname = &"BR_SOA_EVENT/HENCHMAN";
        self.goalradius = randomintrange(100, 200);
        self.scripted_long_deaths = 0;
        self.agentdamagefeedback = 1;
        _testing_ending::ref_13122(0.5);
        _testing_ending::ref_13123(30);
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349f("gas_grenade_mp", 2);
        thread boss_wave();
        thread bot_choose_attack_zone();

        if(isDefined(self.script_noteworthy) && self.script_noteworthy == "guard_tower") {
          self allowedstances("stand");
          thread boss_fight_combat();
        }

        thread blueprint_maxpermatch();
      }

      function blueprintcreatingteam(var_0) {
        self endon("death");
        self endon("game_ended");
        self cleargoalvolume();
        self setgoalpos(self.origin);
        thread bot_cache_entrances_to_zones(30);
        thread bonus_target_domage();
        scripts\engine\utility::ref_143aa("bullet_whizby", "damage", "weapon_fired", "grenade danger", "timeout", "proximty_alert");
        self notify("alert");
        self setgoalvolumeauto(var_0);
      }

      function bot_cache_entrances_to_zones(var_0) {
        self endon("death");
        self endon("game_ended");
        self endon("alert");
        wait var_0;
        self notify("timeout");
      }

      function bonus_target_domage() {
        self endon("death");
        self endon("game_ended");
        self endon("alert");

        for(;;) {
          var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);

          if(var_0.size > 0) {
            self notify("proximty_alert");
            var_1 = scripts\engine\utility::random(var_0);
            self agentsetfavoriteenemy(var_1);
            self getenemyinfo(var_1);
            break;
          }

          wait 1;
        }
      }

      function bomb_detonator_bomb_type() {
        if(!ispointonnavmesh(self.origin, self, 1)) {
          var_0 = getclosestpointonnavmesh(self.origin, self);

          if(isDefined(var_0)) {
            self forceteleport(var_0, self.angles);
            return;
          }

          return;
        }
      }

      function boss_wave() {
        var_0 = [];
        GscBinSkip0(0x2e, "AI_frag_grenade_mp", randomintrange(3000, 5000));
      }

      function bot_choose_attack_zone() {
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
              break;
          }
        }
      }

      function boss_fight_combat() {
        self endon("death");
        self endon("game_ended");

        for(;;) {
          if(isDefined(self.enemy) && isPlayer(self.enemy) && (self.enemy isparachuting() || self.enemy isskydiving())) {
            _testing_ending::ref_13122(0.2);
          }

          _testing_ending::ref_13122(self.circleclosestarttime.baseaccuracy);
          wait 1;
        }
      }

      function blueprint_maxpermatch() {
        self endon("game_ended");
        self waittill("death", var_0);
        level.are_all_hvts_eliminated = scripts\engine\utility::array_remove(level.are_all_hvts_eliminated, self);

        if(isDefined(var_0) && isPlayer(var_0)) {
          var_1 = "kill";
          var_0 thread scripts\mp\rank::giverankxp(var_1, 100);
          var_0 thread scripts\mp\rank::scoreeventpopup(var_1);
        }

        var_2 = spawnStruct();
        var_2.origin = self.origin;
        var_2.angles = self.angles;
        var_2.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
        var_2.itemsdropped = 0;
        var_2.heightoffset = 0;
        var_2 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "ammo");
        var_2.heightoffset += 3;
        var_2 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(1, 1, "plunder");
        var_2.heightoffset += 3;
        var_3 = bonusobjectivescorecharge();
        var_4 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_3, var_2.dropstruct, var_2.origin, var_2.angles, 0, 1, 0);
        var_2.heightoffset += 3;
      }

      function bonusobjectivescorecharge() {
        if(!isDefined(level.arena_bot_out_of_ammo)) {
          bot_br_circle_think();
        }

        return scripts\engine\utility::random(level.arena_bot_out_of_ammo);
      }

      function bot_br_circle_think() {
        level.arena_bot_out_of_ammo = [];
        level.arena_bot_out_of_ammo["brloot_offhand_gas"] = "brloot_offhand_gas";
        level.arena_bot_out_of_ammo["brloot_offhand_smoke"] = "brloot_offhand_smoke";
        level.arena_bot_out_of_ammo["brloot_offhand_flash"] = "brloot_offhand_flash";
        level.arena_bot_out_of_ammo["brloot_killstreak_precision_airstrike"] = "brloot_killstreak_precision_airstrike";
        level.arena_bot_out_of_ammo["brloot_killstreak_uav"] = "brloot_killstreak_uav";
        level.arena_bot_out_of_ammo["brloot_equip_gasmask_durable"] = "brloot_equip_gasmask_durable";
        level.arena_bot_out_of_ammo["brloot_health_adrenaline"] = "brloot_health_adrenaline";
        level.arena_bot_out_of_ammo["brloot_super_nova_rounds"] = "brloot_super_nova_rounds";
        level.arena_bot_out_of_ammo["brloot_offhand_decon_station"] = "brloot_offhand_decon_station";
      }

      function next_drone_cd(var_0, var_1) {
        var_2 = var_1 * var_1;

        foreach(var_4 in level.are_all_hvts_eliminated) {
          if(!isDefined(var_4)) {
            continue;
          }

          if(distance2dsquared(var_4.origin, var_0) > var_2) {
            level.are_all_hvts_eliminated = scripts\engine\utility::array_remove(level.are_all_hvts_eliminated, var_4);
            var_4 dodamage(var_4.health, var_4.origin, var_4, undefined, "MOD_TRIGGER_HURT");
          }
        }
      }